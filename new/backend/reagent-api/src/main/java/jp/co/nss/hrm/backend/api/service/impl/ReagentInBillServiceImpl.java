package jp.co.nss.hrm.backend.api.service.impl;

import cn.hutool.core.date.DateUtil;
import com.github.pagehelper.PageHelper;
import jp.co.nss.hrm.backend.api.dao.*;
import jp.co.nss.hrm.backend.api.dto.*;
import jp.co.nss.hrm.backend.api.enums.BillStatus;
import jp.co.nss.hrm.backend.api.enums.BillType;
import jp.co.nss.hrm.backend.api.service.ReagentAdminService;
import jp.co.nss.hrm.backend.api.service.ReagentInBillService;
import jp.co.nss.hrm.backend.mapper.*;
import jp.co.nss.hrm.backend.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class ReagentInBillServiceImpl implements ReagentInBillService {

    @Autowired
    private ReagentInBillMapper inBillMapper;

    @Autowired
    private ReagentBaseInfoMapper baseInfoMapper;

    @Autowired
    private ReagentInBillDao inBillDao;

    @Autowired
    private ReagentInDetailDao inDetailDao;

    @Autowired
    private ReagentInDetailItemDao inDetailItemDao;

    @Autowired
    private ReagentStockDao stockDao;

    @Autowired
    private ReagentStockDetailDao stockDetailDao;

    @Autowired
    private ReagentPreInDetailDao preInDetailDao;

    @Autowired
    private ReagentInDetailMapper detailMapper;

    @Autowired
    private ReagentInDetailItemMapper itemMapper;

    @Autowired
    private ReagentStockMapper stockMapper;

    @Autowired
    private ReagentStockItemMapper stockItemMapper;

    @Autowired
    private ReagentAdminDao adminDao;

    @Autowired
    private ReagentPreInBillDao preInBillDao;

    @Autowired
    private ReagentPreInDetailItemDao preInItemDao;

    @Autowired
    private ReagentOrderDao orderDao;

    @Autowired
    private ReagentOrderDetailDao orderDetailDao;

    @Autowired
    private ReagentAdminService adminService;

    /**
     * ????????????
     */
    @Override
    public ReagentItem findReagentItem(String qrCode) {

        return inBillDao.findReagentItem(qrCode);
    }

    /**
     * ??????????????????
     */
    @Override
    @Transactional
    public int createInBill(ReagentInBillReq req) {
        try {
            //?????????????????????
            ReagentInBill bill = inBillMapper.selectByPrimaryKey(req.getId());

            //???????????????
            bill.setBillType(BillType.in_act.getValue());
            //bill.setSuppilerShortName(req.getSupplierName());
            bill.setBillDate(DateUtil.parse(req.getBillDate(), "yyyyMMdd"));
            bill.setBillStatus(String.valueOf(BillStatus.real.getValue()));
            bill.setBillCreator(req.getBillCreator());
            //bill.setRemark(req.getRemark());
            bill.setUpdateTime(new Date());
            int billId = inBillMapper.insert(bill);

            //?????????????????????
            List<ReagentDetailReq> list = req.getDetails();
            for (ReagentDetailReq detail : list) {
                //?????????????????????
                ReagentInDetail inDetail = detailMapper.selectByPrimaryKey(detail.getId());
                inDetail.setId(bill.getId());
                inDetail.setCreateTime(new Date());
                inDetail.setQuantity((long) detail.getQrList().size());
                int detailId = detailMapper.insert(inDetail);

                //????????????
                ReagentStock stock = new ReagentStock();
                //stock.setBatchNo(inDetail.getBatchNo());
                stock.setCreateBy(inDetail.getCreateBy());
                stock.setCreateTime(inDetail.getCreateTime());
                //stock.setReagentId(inDetail.getReagentId());
                //stock.setBranchId((long) 0);
                //stock.setExpireDate(inDetail.getExpireDate());
                stock.setQuantity(inDetail.getQuantity()); // todo DB??????
                stock.setUpdateTime(inDetail.getCreateTime());
                stock.setUpdateBy(inDetail.getCreateBy());
                stock.setDeleteFlag((byte) 0); // todo DB??????
                int stockId = stockMapper.insert(stock);

                //QR??????
                List<String> qrList = detail.getQrList();
                for (String qrCode : qrList) {
                    //?????????QR??????
                    ReagentInDetailItem item = new ReagentInDetailItem();
                    item.setInDetailId(inDetail.getInDetailId());
                    item.setQrCode(qrCode);
                    item.setCreateTime(new Date());
                    item.setCreateBy(req.getBillCreator());
                    item.setStatus("1");
                    item.setUpdateTime(new Date());
                    item.setUpdateBy(req.getBillCreator());
                    item.setDeleteFlag((byte) 0); // todo DB??????

                    itemMapper.insert(item);

                    //??????QR??????
                    ReagentStockItem stockItem = new ReagentStockItem();
                    stockItem.setStockId(stock.getId());
                    stockItem.setQrCode(qrCode);
                    stockItem.setCreateTime(new Date());
                    stockItem.setCreateBy(req.getBillCreator());
                    stockItem.setStatus("1");
                    stockItem.setUpdateTime(new Date());
                    stockItem.setUpdateBy(req.getBillCreator());
                    stockItem.setDeleteFlag((byte) 0); // todo DB??????
                    stockItemMapper.insert(stockItem);
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return 1;
    }

    /**
     * pda??????
     *
     * @param req
     * @return ???????????????????????????????????????
     */
    @Override
    @Transactional
    public String createInBillPda(ReagentInBillPDAReq req) {
        String billCreator = req.getBillCreator();
        String billType = req.getBillType();
        String stockType = req.getStockType();
        String createType = req.getCreateType();
        String billStatus = req.getBillStatus();
        String preInBillCode = req.getPreInBillCode();

        String creatorId = adminService.getAdminByUsername(billCreator).getId().toString();

        //web????????????????????????????????????2?????????????????????
        if (billStatus.equals("2")) billStatus = "1";
        List<ReagentInBillMessPDA> inBillMessList = req.getInBillMessList();
        String inBillCodeDraft = inBillMessList.get(0).getBillCode();

        Boolean qrIndexFlag = req.getQrIndexFlag();

        if (qrIndexFlag != null) {
            //??????????????????qrIndexList???????????????codeValue
            for (ReagentInBillMessPDA inBillMess : inBillMessList) {
                List<String> qrs = new ArrayList<>();
                List<String> codeValues = new ArrayList<>();
                List<String> codes = new ArrayList<>();
                String qr;
                String value;
                String code;

                List<ReagentInBillMessPDA> indexValue = inDetailItemDao.searchThreeValue(inBillCodeDraft, inBillMess.getCode(), inBillMess.getBatchNo());
                //??????????????????????????????for????????????????????????mess?????????????????????
                for (ReagentInBillMessPDA index : indexValue) {
                    qr = index.getQrCode();
                    value = index.getCodeValue();
                    code = index.getReagentCode();

                    qrs.add(qr);
                    codeValues.add(value);
                    codes.add(code);
                }
                inBillMess.setQrCodeValueList(codeValues);
                inBillMess.setQrList(qrs);
                inBillMess.setReagentCodeList(codes);
            }
        }

        String inBillCode = null;
        // ????????????????????????????????????????????????????????????????????????
        boolean isDraft = false;

        // ??????????????????????????????????????????
        if (req.getTempInBillCode() != null) {
            isDraft = true;
            inBillCode = req.getTempInBillCode();
        }

        try {
            // ???????????????????????????
            if (isDraft) {
                inDetailItemDao.deleteByInBillCode(inBillCode);
                inDetailDao.deleteByInBillCode(inBillCode);
                inBillDao.deleteByInBillCode(inBillCode);
            }

            List<String> baseInfos = new ArrayList<>();
            inBillMessList.forEach(item -> {
                baseInfos.add(item.getCode());
            });
            ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
            ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
            criteria.andCodeIn(baseInfos);

            // ?????????????????????????????????
            List<ReagentBaseInfo> baseInfoList = baseInfoMapper.selectByExample(baseInfoExample);

            ReagentInBillVm inBillAll = new ReagentInBillVm();

            Long time1 = new Date().getTime();
            Random ne2 = new Random();//???????????????random?????????ne
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
            String random_order2 = String.valueOf(x2);
            if (!isDraft) inBillCode = time1 + random_order2;
            Date timeNow = new Date();

            inBillAll.setBillCode(inBillCode);
            inBillAll.setPreInBillCode(preInBillCode);
            inBillAll.setBillType(billType);
            inBillAll.setCreateType(createType);
            inBillAll.setCreateBy(req.getBillCreator());
            inBillAll.setSupplierId(inBillMessList.get(0).getSupplierId());
            inBillAll.setSupplierShortName(inBillMessList.get(0).getSupplierShortName());
            inBillAll.setBillDate(timeNow);
            inBillAll.setBillStatus(billStatus);
            inBillAll.setBranch(adminDao.selectBranch(req.getBillCreator()));
            inBillAll.setBillCreator(req.getBillCreator());
            inBillAll.setRemark(req.getRemark());
            inBillAll.setUpdateTime(timeNow);
            inBillAll.setCreateTime(timeNow);

            inBillDao.insert(inBillAll);

            // ????????????????????????????????????
            List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();
            String finalInBillCode = inBillCode;
            String finalBillStatus = billStatus;
            inBillMessList.forEach(inBillMessItem -> {
                baseInfoList.forEach(baseInfoItem -> {
                    if (inBillMessItem.getCode().equals(baseInfoItem.getCode())) {
                        Integer number;
                        ReagentInBillDetail inDetail = new ReagentInBillDetail();

                        Long time2 = new Date().getTime();
                        Random ne3 = new Random();//???????????????random?????????ne
                        int x3 = ne3.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                        String random_order3 = String.valueOf(x3);
                        String inDetailId = time2 + random_order3;

                        double totalPrice = inBillMessItem.getPrice() * inBillMessItem.getQuantity();
                        inDetail.setTotal(totalPrice);

                        inDetail.setBillCode(finalInBillCode);
                        inDetail.setInDetailId(inDetailId);
                        inDetail.setReagentId(baseInfoItem.getCode());
                        inDetail.setReagentName(baseInfoItem.getName());
                        inDetail.setReagentUnit(baseInfoItem.getUnit());
                        inDetail.setReagentSpecification(baseInfoItem.getSpecification());
                        inDetail.setFactory(baseInfoItem.getManufacturerName());
                        inDetail.setPrice(inBillMessItem.getPrice());
                        inDetail.setQuantity(inBillMessItem.getQuantity().longValue());

                        inDetail.setBatchNo(inBillMessItem.getBatchNo());
                        inDetail.setExpireDate(inBillMessItem.getExpireDate());
                        inDetail.setRemark(req.getRemark());
                        inDetail.setCreateBy(req.getBillCreator());
                        inDetail.setCreateTime(timeNow);

                        reagentInDetailList.add(inDetail);

                        // ????????????????????????
                        List<ReagentInDetailItem> reagentInDetailItemList = new ArrayList<>();
                        if (inBillMessItem.getInBillNumber() != null) {
                            number = inBillMessItem.getInBillNumber(); //web
                        } else {
                            number = inBillMessItem.getQuantity(); //pda
                        }

                        for (int i = 1; i <= number; i++) {
                            ReagentInDetailItem item = new ReagentInDetailItem();
                            item.setBillCode(finalInBillCode);
                            item.setInDetailId(inDetailId);
                            item.setStatus(finalBillStatus);
                            item.setQrCode(inBillMessItem.getQrList().get(i - 1));
                            item.setCodeValue(inBillMessItem.getQrCodeValueList().get(i - 1));
                            item.setReagentCode(inBillMessItem.getReagentCodeList().get(i - 1));
                            item.setCreateTime(timeNow);
                            item.setCreateBy(req.getBillCreator());
                            reagentInDetailItemList.add(item);
                        }

                        //????????????
                        /*int Diff;
                        if (inBillMessItem.getInBillNumber() != null) {
                            Diff = inBillMessItem.getQuantity() - inBillMessItem.getInBillNumber();
                        } else {
                            Diff = -1;
                        }

                        if (Diff > 0) {
                            //???????????????????????????????????????
                            Date expireDate = inBillMessItem.getExpireDate();
                            String expireDateFormat = String.format("%tY", expireDate) + "-" +
                                    String.format("%tm", expireDate) + "-" +
                                    String.format("%td", expireDate);
                            //?????????????????????
                            StringBuilder codeValue = new StringBuilder("??????: " + baseInfoItem.getName() +
                                    "<br/>??????: " + baseInfoItem.getManufacturerName() +
                                    "<br/>?????????: " + inBillMessItem.getSupplierShortName() +
                                    "<br/>??????: " + inBillMessItem.getBatchNo() +
                                    "<br/>?????????: " + expireDateFormat +
                                    "<br/>??????: ");
                            //String newCodeValue;

                            //???????????????????????????????????????????????????????????????????????????????????????
                            String lastQrCode = inBillMessItem.getQrList().get(inBillMessItem.getInBillNumber() - 1);
                            String lastReagentCode = inBillMessItem.getReagentCodeList().get(inBillMessItem.getInBillNumber() - 1);

                            //StringBuilder qrCode1 = new StringBuilder(lastQrCode.substring(0, 22));
                            String qrCode2 = lastQrCode.substring(24);
                            int qrLength2 = qrCode2.length();
                            int qrCode3 = Integer.parseInt(qrCode2);
                            int qrCode33;
                            int qrLength3;

                            //StringBuilder reagentCode1 = new StringBuilder(lastReagentCode.substring(0, 8));
                            String reagentCode2 = lastReagentCode.substring(8);
                            int codeLength2 = reagentCode2.length();
                            int reagentCode3 = Integer.parseInt(reagentCode2);
                            int reagentCode33;
                            int codeLength3;

                            for (int i = 1; i <= Diff; i++) {
                                ReagentInDetailItem item = new ReagentInDetailItem();
                                item.setBillCode(finalInBillCode);
                                item.setInDetailId(inDetailId);

                                StringBuilder reagentCode1 = new StringBuilder(lastReagentCode.substring(0, 8));
                                StringBuilder qrCode1 = new StringBuilder(lastQrCode.substring(0, 24));
                                String newCodeValue;

                                qrCode33 = qrCode3 + i;
                                qrLength3 = String.valueOf(qrCode33).length();

                                reagentCode33 = reagentCode3 + i;
                                codeLength3 = String.valueOf(reagentCode33).length();

                                //???0??????
                                qrCode1.append("0".repeat(Math.max(0, (qrLength2 - qrLength3))));
                                reagentCode1.append("0".repeat(Math.max(0, (codeLength2 - codeLength3))));

                                item.setQrCode(qrCode1.toString() + qrCode33);
                                item.setReagentCode(reagentCode1.toString() + reagentCode33);
                                //newCodeValue = codeValue.append(reagentCode1.toString()).append(reagentCode33).toString();
                                newCodeValue = codeValue + (reagentCode1.toString() + reagentCode33);
                                item.setCodeValue(newCodeValue);

                                item.setStatus("2");//???????????????????????????????????????
                                item.setCreateTime(timeNow);
                                item.setCreateBy(req.getBillCreator());
                                reagentInDetailItemList.add(item);
                            }
                        }*/
                        inDetailItemDao.insertBillItem(reagentInDetailItemList);
                    }
                });
            });
            inDetailDao.insertInDetail(reagentInDetailList);

            /*
             * start: ???????????????????????????
             */
            //??????????????????????????????????????????-?????????????????????-????????????
            String branch = adminDao.selectBranch(req.getBillCreator());
            if (billStatus.equals("1")) {
                String finalInBillCode1 = inBillCode;
                String finalBillStatus1 = billStatus;
                inBillMessList.forEach(inBillMessItem -> {
                    baseInfoList.forEach(baseInfoItem -> {
                        if (inBillMessItem.getCode().equals(baseInfoItem.getCode())) {
                            // ?????????
                            ReagentStock reagentStock = new ReagentStock();
                            String stockNo;
                            Integer number;
                            if (inBillMessItem.getInBillNumber() != null) {
                                number = inBillMessItem.getInBillNumber();
                            } else {
                                number = inBillMessItem.getQuantity();
                            }

                            //??????????????????????????????ID
                            List<ReagentStock> stockListAll = stockMapper.selectByExample(new ReagentStockExample());
                            List<String> codeInfos = new ArrayList<>();
                            stockListAll.forEach(stockItem -> codeInfos.add(stockItem.getReagentId()));

                            //?????????????????????????????????,????????????????????????
                            if (codeInfos.contains(inBillMessItem.getCode())) {
                                ReagentStockExample example = new ReagentStockExample();
                                example.createCriteria().andReagentIdEqualTo(inBillMessItem.getCode());
                                List<ReagentStock> stockNoList = stockMapper.selectByExample(example);
                                Integer Quantity = Math.toIntExact(stockNoList.get(0).getQuantity() + inBillMessItem.getQuantity());

                                stockNo = stockNoList.get(0).getStockNo();
                                stockDao.updateQBySN(stockNo, Quantity);
                            } else {
                                Long time2 = new Date().getTime();
                                Random ne3 = new Random();//???????????????random?????????ne
                                int x3 = ne3.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                                String random_order3 = String.valueOf(x3);
                                stockNo = time2 + random_order3;

                                reagentStock.setStockNo(stockNo);
                                reagentStock.setStockType(stockType);
                                reagentStock.setReagentId(baseInfoItem.getCode());
                                reagentStock.setReagentName(baseInfoItem.getName());
                                reagentStock.setReagentType(baseInfoItem.getSpecification());
                                reagentStock.setReagentUnit(baseInfoItem.getUnit());
                                reagentStock.setBranchName(branch);
                                reagentStock.setFactory(baseInfoItem.getManufacturerName());
                                reagentStock.setSupplierName(baseInfoItem.getSupplierShortName());
                                reagentStock.setQuantity(inBillMessItem.getQuantity().longValue());
                                reagentStock.setReagentPrice(inBillMessItem.getPrice());
                                reagentStock.setReagentStatus(finalBillStatus1);
                                reagentStock.setReagentTemp(baseInfoItem.getStockType());
                                reagentStock.setLowStock(baseInfoItem.getStockLimit().toString());
                                reagentStock.setOverdue(baseInfoItem.getExpirationLimit());
                                reagentStock.setCreateBy(creatorId);
                                reagentStock.setCreateTime(timeNow);
                                reagentStock.setUpdateBy(creatorId);
                                reagentStock.setUpdateTime(timeNow);

                                stockMapper.insert(reagentStock);
                            }

                            //?????????
                            List<ReagentStockDetail> reagentStockDetailList = new ArrayList<>();

                            for (int i = 0; i < number; i++) {
                                ReagentStockDetail reagentStockDetail = new ReagentStockDetail();
                                reagentStockDetail.setStockNo(stockNo);
                                reagentStockDetail.setStockType(stockType);
                                reagentStockDetail.setReagentId(baseInfoItem.getCode());
                                reagentStockDetail.setReagentName(baseInfoItem.getName());
                                reagentStockDetail.setSpecification(baseInfoItem.getSpecification());
                                reagentStockDetail.setManufacturerName(baseInfoItem.getManufacturerName());
                                reagentStockDetail.setRegistrationNo(baseInfoItem.getRegistrationNo());
                                reagentStockDetail.setSupplierShortName(baseInfoItem.getSupplierShortName());
                                reagentStockDetail.setBranch(branch);
                                reagentStockDetail.setReagentUnit(baseInfoItem.getUnit());
                                reagentStockDetail.setReagentStatus("1998");
                                reagentStockDetail.setReagentTemp(baseInfoItem.getStockType());
                                reagentStockDetail.setCreateBy(creatorId);
                                reagentStockDetail.setCreateTime(timeNow);
                                reagentStockDetail.setUpdateBy(creatorId);
                                reagentStockDetail.setUpdateTime(timeNow);

                                reagentStockDetail.setReagentCode(inBillMessItem.getReagentCodeList().get(i));
                                reagentStockDetail.setQrCode(inBillMessItem.getQrList().get(i));
                                reagentStockDetail.setCodeValue(inBillMessItem.getQrCodeValueList().get(i));
                                reagentStockDetail.setBatchNo(inBillMessItem.getBatchNo());
                                reagentStockDetail.setExpireDate(inBillMessItem.getExpireDate());
                                reagentStockDetail.setOpenPeriod(baseInfoItem.getUseDayLimit());
                                reagentStockDetail.setReagentPrice(inBillMessItem.getPrice());

                                reagentStockDetail.setOverdue(baseInfoItem.getExpirationLimit());
                                if (inBillMessItem.getExpireDate() != null) {
                                    Date d1 = inBillMessItem.getExpireDate();
                                    Date d2 = new Date();
                                    long daysBetween = d1.getTime() - d2.getTime();
                                    long diffDate = daysBetween / 86400000;
                                    int daysDiff;
                                    if (daysBetween < 0) {
                                        daysDiff = (int) diffDate;
                                    } else {
                                        daysDiff = (int) (diffDate + 1);
                                    }
                                    reagentStockDetail.setRemainDay(daysDiff);
                                }
                                reagentStockDetail.setEnterTime(timeNow);
                                reagentStockDetail.setEnterNo(finalInBillCode1);
                                reagentStockDetail.setEnterMan(req.getBillCreator());

                                reagentStockDetailList.add(reagentStockDetail);
                            }

                            //????????????
                            /*int Diff;
                            if (inBillMessItem.getInBillNumber() != null) {
                                Diff = inBillMessItem.getQuantity() - inBillMessItem.getInBillNumber();
                            } else {
                                Diff = -1;
                            }
                            if (Diff > 0) {
                                //???????????????????????????????????????
                                Date expireDate = inBillMessItem.getExpireDate();
                                String expireDateFormat = String.format("%tY", expireDate) + "-" +
                                        String.format("%tm", expireDate) + "-" +
                                        String.format("%td", expireDate);
                                //?????????????????????
                                StringBuilder codeValue = new StringBuilder("??????: " + baseInfoItem.getName() +
                                        "<br/>??????: " + baseInfoItem.getManufacturerName() +
                                        "<br/>?????????: " + inBillMessItem.getSupplierShortName() +
                                        "<br/>??????: " + inBillMessItem.getBatchNo() +
                                        "<br/>?????????: " + expireDateFormat +
                                        "<br/>??????: ");

                                //???????????????????????????????????????????????????????????????????????????????????????
                                String lastQrCode = inBillMessItem.getQrList().get(inBillMessItem.getInBillNumber() - 1);
                                String lastReagentCode = inBillMessItem.getReagentCodeList().get(inBillMessItem.getInBillNumber() - 1);

                                String qrCode2 = lastQrCode.substring(24);
                                int qrLength2 = qrCode2.length();
                                int qrCode3 = Integer.parseInt(qrCode2);
                                int qrCode33;
                                int qrLength3;

                                String reagentCode2 = lastReagentCode.substring(8);
                                int codeLength2 = reagentCode2.length();
                                int reagentCode3 = Integer.parseInt(reagentCode2);
                                int reagentCode33;
                                int codeLength3;

                                for (int j = 1; j <= Diff; j++) {
                                    ReagentStockDetail reagentStockDetail = new ReagentStockDetail();
                                    reagentStockDetail.setStockNo(stockNo);
                                    reagentStockDetail.setStockType(stockType);
                                    reagentStockDetail.setReagentId(baseInfoItem.getCode());
                                    reagentStockDetail.setReagentName(baseInfoItem.getName());
                                    reagentStockDetail.setSpecification(baseInfoItem.getSpecification());
                                    reagentStockDetail.setManufacturerName(baseInfoItem.getManufacturerName());
                                    reagentStockDetail.setRegistrationNo(baseInfoItem.getRegistrationNo());
                                    reagentStockDetail.setSupplierShortName(baseInfoItem.getSupplierShortName());
                                    reagentStockDetail.setBranch(branch);
                                    reagentStockDetail.setReagentUnit(baseInfoItem.getUnit());
                                    reagentStockDetail.setReagentStatus("1998");
                                    reagentStockDetail.setReagentTemp(baseInfoItem.getStockType());

                                    StringBuilder reagentCode1 = new StringBuilder(lastReagentCode.substring(0, 8));
                                    StringBuilder qrCode1 = new StringBuilder(lastQrCode.substring(0, 24));
                                    String newCodeValue;

                                    qrCode33 = qrCode3 + j;
                                    qrLength3 = String.valueOf(qrCode33).length();

                                    reagentCode33 = reagentCode3 + j;
                                    codeLength3 = String.valueOf(reagentCode33).length();

                                    //???0??????
                                    qrCode1.append("0".repeat(Math.max(0, (qrLength2 - qrLength3))));
                                    reagentCode1.append("0".repeat(Math.max(0, (codeLength2 - codeLength3))));
                                    reagentStockDetail.setQrCode(qrCode1.toString() + qrCode33);
                                    reagentStockDetail.setReagentCode(reagentCode1.toString() + reagentCode33);

                                    newCodeValue = codeValue + (reagentCode1.toString() + reagentCode33);
                                    reagentStockDetail.setCodeValue(newCodeValue);
                                    reagentStockDetail.setBatchNo(inBillMessItem.getBatchNo());
                                    reagentStockDetail.setExpireDate(inBillMessItem.getExpireDate());
                                    reagentStockDetail.setOpenPeriod(baseInfoItem.getUseDayLimit());
                                    reagentStockDetail.setReagentPrice(inBillMessItem.getPrice());

                                    reagentStockDetail.setOverdue(baseInfoItem.getExpirationLimit());
                                    reagentStockDetail.setEnterTime(new Date());
                                    reagentStockDetail.setEnterNo(finalInBillCode1);
                                    reagentStockDetail.setEnterMan(req.getBillCreator());
                                    reagentStockDetail.setCreateBy(creatorId);
                                    reagentStockDetail.setCreateTime(timeNow);
                                    reagentStockDetail.setUpdateBy(creatorId);
                                    reagentStockDetail.setUpdateTime(timeNow);

                                    reagentStockDetailList.add(reagentStockDetail);
                                }
                            }*/
                            stockDetailDao.insertStockDetail(reagentStockDetailList);
                        }
                    });
                });

                //????????????????????????
                //??????????????????????????????????????????????????????????????????????????????????????????
                String qrCodeIndex;
                String billCode = null;
                qrCodeIndex = inBillMessList.get(0).getQrList().get(0);
                if (qrCodeIndex != null) {
                    billCode = preInItemDao.getPreCode(qrCodeIndex);
                }
                //??????????????????????????????
                if (billCode != null) {
                    preInBillDao.updateStatus(billCode, billStatus);
                    preInDetailDao.updateStatus(billCode, billStatus);
                    preInItemDao.updateStatus(billCode, billStatus);

                    //?????????????????????????????????????????????????????????????????????
                    //????????????????????????????????????0??????????????????
                    AtomicBoolean isComplate = new AtomicBoolean(true);
                    List<ReagentOrderDetail> judgeOrderList = orderDetailDao.selectByOrderNo(billCode);
                    for (ReagentOrderDetail orderDetail : judgeOrderList) {
                        if (orderDetail.getUnsendNum() != 0) {
                            isComplate.set(false);
                            break;
                        }
                    }
                    String orderStatus;
                    //??????????????????????????????
                    if (isComplate.get()) {
                        orderStatus = "4";
                    } else {
                        //??????????????????????????????
                        orderStatus = "2";
                    }
                    orderDao.updateByON(billCode, orderStatus);
                }

                // ????????????????????????????????????????????????????????????
                // start: ????????????
                if (preInBillCode != null) {
                    List<String> inBillCodeList;
                    inBillCodeList = inBillDao.getInCodeListByPreInCode(preInBillCode);
                    if (inBillCodeList.size() > 0) {
                        inBillDao.deleteByInBillCodeList(inBillCodeList);
                        inDetailDao.deleteByInBillCodeList(inBillCodeList);
                        inDetailItemDao.deleteByInBillCodeList(inBillCodeList);
                    }

                }
                // end: ????????????
            }

            /*
             * end: ???????????????????????????
             */

            //???????????????????????????
            List<ReagentStock> stockListAll = stockDao.selectByBranch(stockType, null, null, null, null, branch);
            for (ReagentStock item : stockListAll) {
                Date d1 = stockDetailDao.findMinDate(item.getStockNo(), branch);
                Date d2 = new Date();
                if (d1 != null) {
                    long daysBetween = d1.getTime() - d2.getTime();
                    //111????????????0?????????222=1??????=0
                    long diffDate = (daysBetween / (60 * 60 * 24 * 1000));
                    int daysDiff;
                    if (daysBetween < 0) {
                        daysDiff = (int) diffDate;
                    } else {
                        daysDiff = (int) (diffDate + 1);
                    }
                    stockDao.updateOverdueStock(item.getStockNo(), daysDiff);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        // ????????????????????????????????????
        if (billStatus.equals("0")) {
            return inBillCode;
        } else {
            return "1";
        }
    }

    /**
     * pda ?????? - ????????????
     */
    @Override
    public Integer createInBillPdaByOneKey(ReagentInBillPDAReq req, String billCreator) {
        String stockType = req.getStockType();
        String preInBillCode = req.getPreInBillCode();

        String billType = "1";  // ?????????????????????
        String createType = "3";    // ??????????????????
        String billStatus = "1";    // 0-?????????1-??????

        if (stockType.equals("3")) {
            billType = "2"; // ????????????????????????
            createType = "4";   // ??????????????????
        }

        String creatorId = adminService.getAdminByUsername(billCreator).getId().toString();
        String userBranch = adminDao.selectBranch(billCreator);

        try {
            // start: ?????????????????????
            List<String> inBillCodeList = inBillDao.getInCodeListByPreInCode(preInBillCode);
            if (inBillCodeList.size() > 0) {
                inBillDao.deleteByInBillCodeList(inBillCodeList);
                inDetailDao.deleteByInBillCodeList(inBillCodeList);
                inDetailItemDao.deleteByInBillCodeList(inBillCodeList);
            }
            // end: ?????????????????????

            Long time1 = new Date().getTime();
            Random ne2 = new Random();  // ???????????????random?????????ne
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;  // ?????????????????????100-999
            String random_order2 = String.valueOf(x2);
            String inBillCode = time1 + random_order2;
            Date timeNow = new Date();

            ReagentPreInBill preInBill = preInBillDao.selectByBillCode(preInBillCode);
            List<ReagentPreInDetail> preInDetailList = preInDetailDao.selectByBillCode(preInBillCode);

            // ??????????????????
            ReagentInBillVm inBillAll = new ReagentInBillVm();
            inBillAll.setBillCode(inBillCode);
            inBillAll.setPreInBillCode(preInBillCode);
            inBillAll.setBillType(billType);
            inBillAll.setCreateType(createType);
            inBillAll.setCreateBy(billCreator);
            inBillAll.setSupplierId(preInBill.getSupplierId());
            inBillAll.setSupplierShortName(preInBill.getSupplierShortName());
            inBillAll.setBillDate(timeNow);
            inBillAll.setBillStatus(billStatus);
            inBillAll.setBranch(userBranch);
            inBillAll.setBillCreator(billCreator);
            inBillAll.setRemark(null);
            inBillAll.setUpdateTime(timeNow);
            inBillAll.setCreateTime(timeNow);

            inBillDao.insert(inBillAll);

            List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();
            List<ReagentPreInDetailItem> preInItemList = new ArrayList<>();

            // ????????????2???3???????????????1???2???
            for (ReagentPreInDetail pid : preInDetailList) {

                // ???????????? detail??????????????? ?????????????????????
                if (pid.getBillStatus().equals("1")) {
                    continue;
                }

                /*
                    start: ????????????????????????????????????
                 */

                // start: ??????????????????
                ReagentInBillDetail inDetail = new ReagentInBillDetail();

                Long time2 = new Date().getTime();
                Random ne3 = new Random();  // ???????????????random?????????ne
                int x3 = ne3.nextInt(999 - 100 + 1) + 100;  // ?????????????????????100-999
                String random_order3 = String.valueOf(x3);
                String inDetailId = time2 + random_order3;

                inDetail.setBillCode(inBillCode);
                inDetail.setTotal(pid.getTotal());
                inDetail.setInDetailId(inDetailId);
                inDetail.setReagentId(pid.getReagentCode());
                inDetail.setReagentName(pid.getReagentName());
                inDetail.setReagentUnit(pid.getReagentUnit());
                inDetail.setReagentSpecification(pid.getReagentSpecification());
                inDetail.setFactory(pid.getFactory());
                inDetail.setPrice(pid.getPrice());
                inDetail.setQuantity(pid.getQuantity());
                inDetail.setBatchNo(pid.getBatchNo());
                inDetail.setExpireDate(pid.getExpireDate());
                inDetail.setRemark(null);
                inDetail.setCreateBy(billCreator);
                inDetail.setCreateTime(timeNow);

                reagentInDetailList.add(inDetail);
                // end: ??????????????????

                // start: ???????????????
                ReagentStock reagentStock = new ReagentStock();
                List<ReagentStock> reagentStockList = stockDao.selectByReagentId(pid.getReagentCode());

                String stockNo;
                ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
                ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
                criteria.andCodeEqualTo(pid.getReagentCode());
                List<ReagentBaseInfo> baseInfoList = baseInfoMapper.selectByExample(baseInfoExample);
                ReagentBaseInfo baseInfo = baseInfoList.get(0);

                // ?????????????????????????????????,????????????????????????
                if (reagentStockList.size() > 0) {
                    ReagentStockExample example = new ReagentStockExample();
                    example.createCriteria().andReagentIdEqualTo(pid.getReagentCode());
                    List<ReagentStock> stockNoList = stockMapper.selectByExample(example);
                    Integer Quantity = Math.toIntExact(stockNoList.get(0).getQuantity() + pid.getQuantity());

                    stockNo = stockNoList.get(0).getStockNo();
                    stockDao.updateQBySN(stockNo, Quantity);
                } else {    // ???????????????????????????
                    int x31 = ne3.nextInt(999 - 100 + 1) + 100; // ?????????????????????100-999
                    String random_order31 = String.valueOf(x31);
                    stockNo = time2 + random_order31;

                    reagentStock.setStockNo(stockNo);
                    reagentStock.setStockType(stockType);
                    reagentStock.setReagentId(pid.getReagentCode());
                    reagentStock.setReagentName(pid.getReagentName());
                    reagentStock.setReagentType(pid.getReagentSpecification());
                    reagentStock.setReagentUnit(pid.getReagentUnit());
                    reagentStock.setBranchName(userBranch);
                    reagentStock.setFactory(pid.getFactory());
                    reagentStock.setSupplierName(preInBill.getSupplierShortName());
                    reagentStock.setQuantity(pid.getQuantity());
                    reagentStock.setReagentPrice(pid.getPrice());
                    reagentStock.setReagentStatus(billStatus);
                    reagentStock.setReagentTemp(baseInfo.getStockType());
                    reagentStock.setLowStock(baseInfo.getStockLimit().toString());
                    reagentStock.setOverdue(baseInfo.getExpirationLimit());
                    reagentStock.setCreateBy(creatorId);
                    reagentStock.setCreateTime(timeNow);
                    reagentStock.setUpdateBy(creatorId);
                    reagentStock.setUpdateTime(timeNow);

                    stockMapper.insert(reagentStock);
                }
                /*
                    end: ????????????????????????????????????
                 */

                /*
                    start: ????????????????????????????????????
                 */
                List<ReagentInDetailItem> reagentInDetailItemList = new ArrayList<>();
                List<ReagentStockDetail> reagentStockDetailList = new ArrayList<>();

                preInItemList = preInItemDao.selectByInDetailId(pid.getInDetailId());

                for (ReagentPreInDetailItem pidi : preInItemList) {
                    // start: ??????????????????
                    ReagentInDetailItem item = new ReagentInDetailItem();

                    item.setBillCode(inBillCode);
                    item.setInDetailId(inDetailId);
                    item.setStatus(billStatus);
                    item.setQrCode(pidi.getQrCode());
                    item.setCodeValue(pidi.getCodeValue());
                    item.setReagentCode(pidi.getReagentCode());
                    item.setCreateTime(timeNow);
                    item.setCreateBy(req.getBillCreator());

                    reagentInDetailItemList.add(item);
                    // end: ??????????????????

                    // start: ???????????????
                    ReagentStockDetail reagentStockDetail = new ReagentStockDetail();

                    reagentStockDetail.setStockNo(stockNo);
                    reagentStockDetail.setStockType(stockType);
                    reagentStockDetail.setReagentId(pid.getReagentCode());
                    reagentStockDetail.setReagentName(baseInfo.getName());
                    reagentStockDetail.setSpecification(baseInfo.getSpecification());
                    reagentStockDetail.setManufacturerName(baseInfo.getManufacturerName());
                    reagentStockDetail.setRegistrationNo(baseInfo.getRegistrationNo());
                    reagentStockDetail.setSupplierShortName(baseInfo.getSupplierShortName());
                    reagentStockDetail.setBranch(userBranch);
                    reagentStockDetail.setReagentUnit(baseInfo.getUnit());
                    reagentStockDetail.setReagentStatus("1998");
                    reagentStockDetail.setReagentTemp(baseInfo.getStockType());
                    reagentStockDetail.setCreateBy(creatorId);
                    reagentStockDetail.setCreateTime(timeNow);
                    reagentStockDetail.setUpdateBy(creatorId);
                    reagentStockDetail.setUpdateTime(timeNow);
                    reagentStockDetail.setReagentCode(pidi.getReagentCode());
                    reagentStockDetail.setQrCode(pidi.getQrCode());
                    reagentStockDetail.setCodeValue(pidi.getCodeValue());
                    reagentStockDetail.setBatchNo(pid.getBatchNo());
                    reagentStockDetail.setExpireDate(pid.getExpireDate());
                    reagentStockDetail.setOpenPeriod(baseInfo.getUseDayLimit());
                    reagentStockDetail.setReagentPrice(pid.getPrice());
                    reagentStockDetail.setOverdue(baseInfo.getExpirationLimit());
                    if (pid.getExpireDate() != null) {
                        Date d1 = pid.getExpireDate();
                        Date d2 = new Date();
                        long daysBetween = d1.getTime() - d2.getTime();
                        long diffDate = daysBetween / 86400000;
                        int daysDiff;
                        if (daysBetween < 0) {
                            daysDiff = (int) diffDate;
                        } else {
                            daysDiff = (int) (diffDate + 1);
                        }
                        reagentStockDetail.setRemainDay(daysDiff);
                    }
                    reagentStockDetail.setEnterTime(timeNow);
                    reagentStockDetail.setEnterNo(inBillCode);
                    reagentStockDetail.setEnterMan(billCreator);

                    reagentStockDetailList.add(reagentStockDetail);
                    // end: ???????????????
                }

                inDetailItemDao.insertBillItem(reagentInDetailItemList);
                stockDetailDao.insertStockDetail(reagentStockDetailList);
                /*
                    end: ????????????????????????????????????
                 */
            }

            inDetailDao.insertInDetail(reagentInDetailList);

            // ????????????????????????
            String qrCodeRandom = preInItemList.get(0).getQrCode();
            String billCode = null;
            if (qrCodeRandom != null) {
                billCode = preInItemDao.getPreCode(qrCodeRandom);
            }
            if (billCode != null) {
                preInBillDao.updateStatus(billCode, billStatus);
                preInDetailDao.updateStatus(billCode, billStatus);
                preInItemDao.updateStatus(billCode, billStatus);

                //?????????????????????????????????????????????????????????????????????
                //????????????????????????????????????0??????????????????
                AtomicBoolean isComplate = new AtomicBoolean(true);
                List<ReagentOrderDetail> judgeOrderList = orderDetailDao.selectByOrderNo(billCode);
                for (ReagentOrderDetail orderDetail : judgeOrderList) {
                    if (orderDetail.getUnsendNum() != 0) {
                        isComplate.set(false);
                        break;
                    }
                }
                String orderStatus;
                //??????????????????????????????
                if (isComplate.get()) {
                    orderStatus = "4";
                } else {
                    //??????????????????????????????
                    orderStatus = "2";
                }
                orderDao.updateByON(billCode, orderStatus);
            }
            //???????????????????????????
            //??????????????????????????????????????????-?????????????????????-????????????
            List<ReagentStock> stockListAll = stockDao.selectByBranch(stockType, null, null, null, null, userBranch);
            for (ReagentStock item : stockListAll) {
                Date d1 = stockDetailDao.findMinDate(item.getStockNo(), userBranch);
                Date d2 = new Date();
                if (d1 != null) {
                    long daysBetween = d1.getTime() - d2.getTime();
                    //111????????????0?????????222=1??????=0
                    long diffDate = (daysBetween / (60 * 60 * 24 * 1000));
                    int daysDiff;
                    if (daysBetween < 0) {
                        daysDiff = (int) diffDate;
                    } else {
                        daysDiff = (int) (diffDate + 1);
                    }
                    stockDao.updateOverdueStock(item.getStockNo(), daysDiff);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }

    /**
     * ???????????????
     *
     * @param inBill
     */
    @Override
    public int create(ReagentInBillPost inBill) {
        String indexCode = inBill.getBillCode();
        String inBillStates = inBill.getBillStatus();
        String billType = inBill.getBillType();
        String stockType = inBill.getStockType();
        String createType = inBill.getCreateType();
        int formatTime = 86400000;
        String creatorId = adminService.getAdminByUsername(inBill.getBillCreator()).getId().toString();
        List<ReagentInBillMess> inBillMessList = inBill.getInBillMessList();

        List<String> baseInfos = new ArrayList<>();
        inBillMessList.forEach(item -> baseInfos.add(item.getCode()));

        try {
            ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
            ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
            criteria.andCodeIn(baseInfos);

            // ?????????????????????????????????
            List<ReagentBaseInfo> baseInfoList = baseInfoMapper.selectByExample(baseInfoExample);
            String inBillCode;
            String finalInBillCode;
            if (indexCode == null) {
                //indexCode?????????????????????????????????????????????
                ReagentInBill inBillAll = new ReagentInBill();

                Long time1 = new Date().getTime();
                Random ne2 = new Random();//???????????????random?????????ne
                int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                String random_order2 = String.valueOf(x2);
                inBillCode = time1 + random_order2;

                inBillAll.setBillCode(inBillCode);
                inBillAll.setBillType(billType);
                inBillAll.setCreateType(createType);
                inBillAll.setSupplierId(inBillMessList.get(0).getSupplierId());
                inBillAll.setSupplierShortName(inBillMessList.get(0).getSupplierShortName());
                inBillAll.setBillDate(new Date());
                inBillAll.setBillStatus(inBillStates);
                inBillAll.setBranch(adminDao.selectBranch(inBill.getBillCreator()));
                inBillAll.setBillCreator(inBill.getBillCreator());
                inBillAll.setRemark(inBill.getRemark());
                inBillAll.setUpdateTime(new Date());
                inBillAll.setCreateTime(new Date());

                inBillMapper.insert(inBillAll);

                finalInBillCode = inBillCode;
            } else {
                //indexCode???????????????????????????????????????,?????????????????????????????????????????????????????????,??????????????????????????????
                finalInBillCode = indexCode;
                if (inBillStates.equals("1")) {
                    inBillDao.updateByBC(indexCode, inBillStates);
                }
                inDetailDao.deleteByInBillCode(indexCode);
                inDetailItemDao.deleteByInBillCode(indexCode);
            }

            List<String> inDetailIdItem = new ArrayList<>();
            // ????????????????????????????????????
            List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();

            inBillMessList.forEach(inBillMessItem -> {
                baseInfoList.forEach(baseInfoItem -> {
                    if (inBillMessItem.getCode().equals(baseInfoItem.getCode())) {
                        ReagentInBillDetail inDetail = new ReagentInBillDetail();

                        Long time1 = new Date().getTime();
                        Random ne2 = new Random();//???????????????random?????????ne
                        int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                        String random_order2 = String.valueOf(x2);
                        String inDetailId = time1 + random_order2;
                        //??????????????????ID
                        inDetailIdItem.add(inDetailId);

                        double totalPrice = inBillMessItem.getPrice() * inBillMessItem.getQuantity();
                        inDetail.setTotal(totalPrice);

                        inDetail.setBillCode(finalInBillCode);
                        inDetail.setInDetailId(inDetailId);
                        inDetail.setReagentId(baseInfoItem.getCode());
                        inDetail.setReagentName(baseInfoItem.getName());
                        inDetail.setReagentUnit(baseInfoItem.getUnit());

                        inDetail.setReagentSpecification(baseInfoItem.getSpecification());
                        inDetail.setFactory(baseInfoItem.getManufacturerName());
                        inDetail.setPrice(inBillMessItem.getPrice());
                        inDetail.setQuantity(inBillMessItem.getQuantity().longValue());

                        inDetail.setBatchNo(inBillMessItem.getBatchNo());
                        inDetail.setExpireDate(inBillMessItem.getExpireDate());
                        inDetail.setRemark(inBill.getRemark());

                        reagentInDetailList.add(inDetail);

                        // ????????????????????????
                        List<ReagentInDetailItem> reagentInDetailItemList = new ArrayList<>();

                        //???????????????????????????????????????
                        Date expireDate = inBillMessItem.getExpireDate();
                        String expireDateFormat = String.format("%tY", expireDate) + "-" +
                                String.format("%tm", expireDate) + "-" +
                                String.format("%td", expireDate);

                        String reagentId = baseInfoItem.getCode();
                        String batchNo = inBillMessItem.getBatchNo();
                        String stockCount = stockDetailDao.countBatchNo(reagentId, batchNo);
                        String preCount = preInDetailDao.countBatchNo(reagentId, batchNo);

                        int numCount;
                        if (stockCount == null) stockCount = "0";
                        if (preCount == null) preCount = "0";
                        numCount = Integer.parseInt(stockCount) + Integer.parseInt(preCount);

                        for (int i = numCount + 1; i <= numCount + inBillMessItem.getQuantity(); i++) {
                            ReagentInDetailItem reagentInDetailItem = new ReagentInDetailItem();
                            reagentInDetailItem.setBillCode(finalInBillCode);
                            reagentInDetailItem.setCreateTime(new Date());
                            reagentInDetailItem.setInDetailId(inDetailId);
                            String sort;

                            if (numCount + inBillMessItem.getQuantity() < 1000) {
                                if (i < 10) {
                                    sort = "00" + i;
                                } else if (i < 100) {
                                    sort = "0" + i;
                                } else {
                                    sort = Integer.toString(i);
                                }
                            } else if (numCount + inBillMessItem.getQuantity() < 10000) {
                                if (i < 10) {
                                    sort = "000" + i;
                                } else if (i < 100) {
                                    sort = "00" + i;
                                } else if (i < 1000) {
                                    sort = "0" + i;
                                } else {
                                    sort = Integer.toString(i);
                                }
                            } else {
                                if (i < 10) {
                                    sort = "0000" + i;
                                } else if (i < 100) {
                                    sort = "000" + i;
                                } else if (i < 1000) {
                                    sort = "00" + i;
                                } else if (i < 10000) {
                                    sort = "0" + i;
                                } else {
                                    sort = Integer.toString(i);
                                }
                            }
                            String reagentCode = inBillMessItem.getBatchNo() + sort;
                            reagentInDetailItem.setReagentCode(reagentCode);
                            reagentInDetailItem.setCreateBy(inBill.getBillCreator());
                            String status;
                            //?????????createType????????????????????????????????????????????????????????????????????????????????????????????????2?????????????????????inBillStates
                            /*if (createType.equals("3") || createType.equals("4")) {
                                status = "2";
                            } else {
                                status = inBillStates;
                            }*/
                            //????????????????????????????????????????????????????????????
                            status = inBillStates;
                            reagentInDetailItem.setStatus(status);

                            //?????????????????????
                            String codeValue = "??????: " + baseInfoItem.getName() +
                                    "<br/>??????: " + baseInfoItem.getManufacturerName() +
                                    "<br/>?????????: " + inBillMessItem.getSupplierShortName() +
                                    "<br/>??????: " + inBillMessItem.getBatchNo() +
                                    "<br/>?????????: " + expireDateFormat +
                                    "<br/>??????: " + reagentCode;

                            String qrCode = inDetailId + reagentCode;
                            reagentInDetailItem.setCodeValue(codeValue);
                            reagentInDetailItem.setQrCode(qrCode);

                            reagentInDetailItemList.add(reagentInDetailItem);
                        }
                        inDetailItemDao.insertBillItem(reagentInDetailItemList);
                    }
                });
            });
            inDetailDao.insertInDetail(reagentInDetailList);

            //??????????????????????????????????????????
            //??????????????????????????????????????????-?????????????????????-????????????
            String branch = adminDao.selectBranch(inBill.getBillCreator());
            if (inBillStates.equals("1")) {
                //???????????? reagentStock
                AtomicInteger item = new AtomicInteger();
                inBillMessList.forEach(inBillMessItem -> {
                    int finalI = item.get();
                    baseInfoList.forEach(baseInfoItem -> {
                        if (inBillMessItem.getCode().equals(baseInfoItem.getCode())) {
                            //?????????
                            ReagentStock reagentStock = new ReagentStock();
                            String stockNo;

                            //??????????????????????????????ID
                            List<ReagentStock> stockListAll = stockMapper.selectByExample(new ReagentStockExample());
                            List<String> codeInfos = new ArrayList<>();
                            stockListAll.forEach(stockItem -> codeInfos.add(stockItem.getReagentId()));

                            //?????????????????????????????????,????????????????????????
                            if (codeInfos.contains(inBillMessItem.getCode())) {
                                ReagentStockExample example = new ReagentStockExample();
                                example.createCriteria().andReagentIdEqualTo(inBillMessItem.getCode());
                                List<ReagentStock> stockNoList = stockMapper.selectByExample(example);
                                Integer Quantity = Math.toIntExact(stockNoList.get(0).getQuantity() + inBillMessItem.getQuantity());
                                stockNo = stockNoList.get(0).getStockNo();
                                stockDao.updateQBySN(stockNo, Quantity);
                            } else {
                                Long time1 = new Date().getTime();
                                Random ne2 = new Random();//???????????????random?????????ne
                                int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                                String random_order2 = String.valueOf(x2);
                                stockNo = time1 + random_order2;

                                reagentStock.setStockNo(stockNo);
                                reagentStock.setStockType(stockType);
                                reagentStock.setReagentId(baseInfoItem.getCode());
                                reagentStock.setReagentName(baseInfoItem.getName());
                                reagentStock.setReagentType(baseInfoItem.getSpecification());
                                reagentStock.setReagentUnit(baseInfoItem.getUnit());
                                reagentStock.setFactory(baseInfoItem.getManufacturerName());
                                reagentStock.setSupplierName(baseInfoItem.getSupplierShortName());
                                reagentStock.setBranchName(branch);
                                reagentStock.setQuantity(inBillMessItem.getQuantity().longValue());
                                reagentStock.setReagentPrice(inBillMessItem.getPrice());
                                reagentStock.setReagentStatus(inBillStates);
                                reagentStock.setReagentTemp(baseInfoItem.getStockType());
                                reagentStock.setLowStock(baseInfoItem.getStockLimit().toString());
                                reagentStock.setOverdue(baseInfoItem.getExpirationLimit());
                                reagentStock.setCreateTime(new Date());
                                reagentStock.setCreateBy(creatorId);
                                reagentStock.setUpdateTime(new Date());
                                reagentStock.setUpdateBy(creatorId);

                                stockMapper.insert(reagentStock);
                            }
                            //?????????
                            List<ReagentStockDetail> reagentStockDetailList = new ArrayList<>();

                            //???????????????????????????????????????
                            Date expireDate = inBillMessItem.getExpireDate();
                            String expireDateFormat = String.format("%tY", expireDate) + "-" +
                                    String.format("%tm", expireDate) + "-" +
                                    String.format("%td", expireDate);

                            String reagentId = baseInfoItem.getCode();
                            String batchNo = inBillMessItem.getBatchNo();
                            String stockCount = stockDetailDao.countBatchNo(reagentId, batchNo);
                            String preCount = preInDetailDao.countBatchNo(reagentId, batchNo);

                            int numCount;
                            if (stockCount == null) stockCount = "0";
                            if (preCount == null) preCount = "0";
                            numCount = Integer.parseInt(stockCount) + Integer.parseInt(preCount);

                            for (int j = numCount + 1; j <= numCount + inBillMessItem.getQuantity(); j++) {
                                ReagentStockDetail reagentStockDetail = new ReagentStockDetail();
                                //??????????????????
                                String sort;
                                if (numCount + inBillMessItem.getQuantity() < 1000) {
                                    if (j < 10) {
                                        sort = "00" + j;
                                    } else if (j < 100) {
                                        sort = "0" + j;
                                    } else {
                                        sort = Integer.toString(j);
                                    }
                                } else if (numCount + inBillMessItem.getQuantity() < 10000) {
                                    if (j < 10) {
                                        sort = "000" + j;
                                    } else if (j < 100) {
                                        sort = "00" + j;
                                    } else if (j < 1000) {
                                        sort = "0" + j;
                                    } else {
                                        sort = Integer.toString(j);
                                    }
                                } else {
                                    if (j < 10) {
                                        sort = "0000" + j;
                                    } else if (j < 100) {
                                        sort = "00" + j;
                                    } else if (j < 1000) {
                                        sort = "00" + j;
                                    } else if (j < 10000) {
                                        sort = "0" + j;
                                    } else {
                                        sort = Integer.toString(j);
                                    }
                                }
                                String reagentCode = inBillMessItem.getBatchNo() + sort;
                                String qrCode = inDetailIdItem.get(finalI) + reagentCode;

                                reagentStockDetail.setStockNo(stockNo);
                                reagentStockDetail.setStockType(stockType);
                                reagentStockDetail.setReagentId(baseInfoItem.getCode());
                                reagentStockDetail.setReagentName(baseInfoItem.getName());
                                reagentStockDetail.setSpecification(baseInfoItem.getSpecification());
                                reagentStockDetail.setManufacturerName(baseInfoItem.getManufacturerName());
                                reagentStockDetail.setRegistrationNo(baseInfoItem.getRegistrationNo());
                                reagentStockDetail.setSupplierShortName(baseInfoItem.getSupplierShortName());
                                reagentStockDetail.setReagentUnit(baseInfoItem.getUnit());
                                reagentStockDetail.setReagentStatus("1998");
                                reagentStockDetail.setBranch(branch);
                                reagentStockDetail.setReagentTemp(baseInfoItem.getStockType());
                                reagentStockDetail.setReagentCode(reagentCode);
                                reagentStockDetail.setQrCode(qrCode);

                                //?????????????????????
                                String codeValue = "??????: " + baseInfoItem.getName() +
                                        "<br/>??????: " + baseInfoItem.getManufacturerName() +
                                        "<br/>?????????: " + baseInfoItem.getSupplierShortName() +
                                        "<br/>??????: " + inBillMessItem.getBatchNo() +
                                        "<br/>?????????: " + expireDateFormat +
                                        "<br/>??????: " + reagentCode;

                                reagentStockDetail.setCodeValue(codeValue);
                                reagentStockDetail.setBatchNo(inBillMessItem.getBatchNo());
                                reagentStockDetail.setExpireDate(inBillMessItem.getExpireDate());
                                reagentStockDetail.setOpenPeriod(baseInfoItem.getUseDayLimit());
                                reagentStockDetail.setReagentPrice(inBillMessItem.getPrice());

                                reagentStockDetail.setOverdue(baseInfoItem.getExpirationLimit());

                                if (inBillMessItem.getExpireDate() != null) {
                                    Date d1 = inBillMessItem.getExpireDate();
                                    Date d2 = new Date();
                                    long daysBetween = d1.getTime() - d2.getTime();
                                    long diffDate = daysBetween / formatTime;
                                    int daysDiff;
                                    if (daysBetween < 0) {
                                        daysDiff = (int) diffDate;
                                    } else {
                                        daysDiff = (int) (diffDate + 1);
                                    }
                                    reagentStockDetail.setRemainDay(daysDiff);
                                }

                                reagentStockDetail.setEnterTime(new Date());
                                reagentStockDetail.setEnterNo(finalInBillCode);
                                reagentStockDetail.setEnterMan(inBill.getBillCreator());
                                reagentStockDetail.setCreateTime(new Date());
                                reagentStockDetail.setUpdateTime(new Date());
                                reagentStockDetail.setUpdateBy(creatorId);
                                reagentStockDetail.setCreateBy(creatorId);

                                reagentStockDetailList.add(reagentStockDetail);
                            }
                            stockDetailDao.insertStockDetail(reagentStockDetailList);
                        }
                    });
                    item.incrementAndGet();
                });
                //stockDao.insertStock(reagentStockList);
            }
            //???????????????????????????
            List<ReagentStock> stockListAll = stockDao.selectByBranch(stockType, null, null, null, null, branch);
            for (ReagentStock item : stockListAll) {
                Date d1 = stockDetailDao.findMinDate(item.getStockNo(), branch);
                Date d2 = new Date();
                if (d1 != null) {
                    long daysBetween = d1.getTime() - d2.getTime();
                    //111????????????0?????????222=1??????=0
                    long diffDate = (daysBetween / (60 * 60 * 24 * 1000));
                    int daysDiff;
                    if (daysBetween < 0) {
                        daysDiff = (int) diffDate;
                    } else {
                        daysDiff = (int) (diffDate + 1);
                    }
                    stockDao.updateOverdueStock(item.getStockNo(), daysDiff);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return 1;
    }

    @Override
    public List<ReagentInBill> getAllByBillType(String billType) {

        return inBillDao.getAllByBillType(billType);
    }

    /**
     * ??????????????????
     *
     * @param id
     * @param inBill
     */
    @Override
    public int update(Long id, ReagentInBill inBill) {
        inBill.setId(id);
        return inBillMapper.updateByPrimaryKeySelective(inBill);
    }

    /**
     * ???????????????????????????????????????
     *
     * @param billCode
     * @param inBill
     */
    @Override
    public int updateByBC(String billCode, ReagentInBill inBill) {
        String billStatus = inBill.getBillStatus();
        return inBillDao.updateByBC(billCode, billStatus);
    }

    /**
     * ??????????????????
     *
     * @param ids
     */
    @Override
    public int delete(List<Long> ids) {
        ReagentInBillExample example = new ReagentInBillExample();
        example.createCriteria().andIdIn(ids);
        int count = inBillMapper.deleteByExample(example);
        return count;
    }

    public int deleteByBillCode(String billCode) {
        ReagentInBillExample example = new ReagentInBillExample();
        example.createCriteria().andBillCodeEqualTo(billCode);
        int count = inBillMapper.deleteByExample(example);
        return count;
    }

    @Override
    public List<ReagentInBill> list(String billType, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        ReagentInBillExample example = new ReagentInBillExample();
        ReagentInBillExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(billType)) {
            criteria.andBillTypeEqualTo(billType);
        }
        return inBillMapper.selectByExample(example);
    }

    @Override
    public List<ReagentInBillVm> searchList(String billType, String username, String keyword, Integer pageSize, Integer pageNum) {
        String branch = adminDao.selectBranch(username);
        List<ReagentInBillVm> inBillList;

        PageHelper.startPage(pageNum, pageSize);
        inBillList = inBillDao.selectByBranch(billType, keyword, branch);

        return inBillList;
    }

    /**
     * ????????????????????????????????????
     *
     * @param billCode
     */
    @Override
    public List<ReagentItem> searchCodeList(String billCode, String createType) {
        List<ReagentItem> codeList;
        String status = null;
        //?????????????????????????????????????????????status??????????????????????????????????????????2????????????
        if (createType.equals("1") || createType.equals("2")) {
            status = null;
        } else if (createType.equals("3") || createType.equals("4")) {
            status = "2";
        }
        codeList = inDetailItemDao.searchCodeByBC(billCode, status);
        return codeList;
    }
}
