package jp.co.nss.hrm.backend.api.service.impl;

import com.github.pagehelper.PageHelper;
import jp.co.nss.hrm.backend.api.dao.*;
import jp.co.nss.hrm.backend.api.dto.ReagentOutDetailItem;
import jp.co.nss.hrm.backend.api.dto.*;
import jp.co.nss.hrm.backend.api.enums.BillStatus;
import jp.co.nss.hrm.backend.api.service.ReagentAdminService;
import jp.co.nss.hrm.backend.api.service.ReagentCollectService;
import jp.co.nss.hrm.backend.mapper.*;
import jp.co.nss.hrm.backend.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class ReagentCollectServiceImpl implements ReagentCollectService {

    @Autowired
    private ReagentBaseInfoMapper baseInfoMapper;

    @Autowired
    private ReagentCollectMapper collectMapper;

    @Autowired
    private ReagentOutBillMapper outBillMapper;

    @Autowired
    private ReagentStockMapper stockInfoMapper;

    @Autowired
    private ReagentStockDetailDao stockDetailDao;

    @Autowired
    private ReagentStockMapper stockMapper;

    @Autowired
    private ReagentStockItemMapper stockItemMapper;

    @Autowired
    private ReagentAdminDao adminDao;

    @Autowired
    private ReagentCollectDetailDao collectDetailDao;

    @Autowired
    private ReagentOutDetailDao outDetailDao;

    @Autowired
    private ReagentOutItemDao outDetailItemDao;

    @Autowired
    private ReagentCollectDao collectDao;

    @Autowired
    private ReagentInBillMapper inBillMapper;

    @Autowired
    private ReagentInBillDao inBillDao;

    @Autowired
    private ReagentInDetailDao inDetailDao;

    @Autowired
    private ReagentInDetailItemDao inDetailItemDao;

    @Autowired
    private ReagentStockDao stockDao;

    @Autowired
    private ReagentInDetailItemDao inItemDao;

    @Autowired
    private ReagentAdminRoleRelationDao adminRoleDao;

    @Autowired
    private ReagentAdminService adminService;

    @Autowired
    private ReagentPreInBillDao preInBillDao;

    @Autowired
    private ReagentPreInDetailDao preInDetailDao;

    @Autowired
    private ReagentPreInDetailItemDao preInItemDao;

    @Autowired
    private ReagentOrderDao orderDao;

    @Autowired
    private ReagentOrderDetailDao orderDetailDao;

    @Autowired
    private ReagentBranchMapper reagentBranchMapper;

    @Autowired
    private ReagentAdminMapper reagentAdminMapper;

    @Autowired
    private ReagentAdminRoleRelationMapper reagentAdminRoleRelationMapper;

    /**
     * ????????????????????????
     */
    @Override
    public List<ReagentCollect> list() {

        return collectMapper.selectByExample(new ReagentCollectExample());
    }

    /**
     * ??????????????????
     *
     * @param collect
     */
    @Override
    public int create(ReagentCollectPost collect) {
        String collectStates = collect.getCollectState();
        String applyType = collect.getApplyType();
        String username = collect.getUsername();
        String branch = adminDao.selectBranch(username);
        List<ReagentCollectMess> collectMessList = collect.getCollectMessList();
        List<String> stockInfos = new ArrayList<>();
        collectMessList.forEach(item -> {
            stockInfos.add(item.getStockNo());
        });

        // ????????????A=1???S=2??????????????????????????????????????????1
        // ????????????A=3???S=1??????????????????????????????????????????2
        // ??????A=2???S=1??????????????????????????????????????????1
        try {
            // ????????????????????????????????????????????????
            ReagentStockExample stockInfoExample = new ReagentStockExample();
            ReagentStockExample.Criteria criteria = stockInfoExample.createCriteria();
            criteria.andStockNoIn(stockInfos);

            // ?????????????????????????????????
            List<ReagentStock> stockList = stockInfoMapper.selectByExample(stockInfoExample);

            // ?????????????????????????????????
            ReagentCollect collectItem = new ReagentCollect();

            collectItem.setCollectStatus(collectStates);
            collectItem.setCollectDay(new Date());
            collectItem.setApplyType(applyType);
            collectItem.setCollectDescribe(collect.getCollectDescribe());
            collectItem.setCreateName(collect.getUsername());
            collectItem.setCreateTime(new Date());
            //???????????????????????????
            if (applyType.equals("2") || applyType.equals("1")) {
                collectItem.setBranch(branch);
            }

            Long time1 = new Date().getTime();
            Random ne2 = new Random();//???????????????random?????????ne
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
            String random_order2 = String.valueOf(x2);
            String collectNo = time1 + random_order2;

            collectItem.setCollectNo(collectNo);

            collectMapper.insert(collectItem);

            // ????????????????????????????????????
            List<ReagentCollectDetail> reagentCollectDetailList = new ArrayList<>();
            collectMessList.forEach(collectMessItem -> {
                stockList.forEach(stockInfoItem -> {
                    if (collectMessItem.getStockNo().equals(stockInfoItem.getStockNo())) {
                        ReagentCollectDetail collectDetail = new ReagentCollectDetail();
                        collectDetail.setCollectNo(collectNo);
                        collectDetail.setReagentCode(stockInfoItem.getReagentId());
                        collectDetail.setReagentName(stockInfoItem.getReagentName());
                        collectDetail.setSupplierShortName(stockInfoItem.getSupplierName());
                        collectDetail.setFactory(stockInfoItem.getFactory());
                        collectDetail.setUnit(stockInfoItem.getReagentUnit());
                        collectDetail.setReagentType(stockInfoItem.getReagentType());
                        collectDetail.setPrice(stockInfoItem.getReagentPrice());
                        collectDetail.setReagentNumber(Long.valueOf(collectMessItem.getReagentNumber()));
                        collectDetail.setCreateTime(new Date());
                        collectDetail.setCreateBy(collect.getUsername());
                        reagentCollectDetailList.add(collectDetail);
                    }
                });
            });
            collectDetailDao.insertCollectDetail(reagentCollectDetailList);

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * pda??????????????????
     *
     * @param req
     */
    @Override
    public int relocation(ReagentCollectPost req) {
        try {
            //???????????????????????????????????????
            String branch;
            String collectNo = req.getCollectNo();
            List<String> qrList = req.getQrList();

            String outType = req.getOutType();
            String inType = req.getInType();
            String createType = req.getCreateType();
            String applyInType = req.getApplyInType();
            String collectStatus = null;
            String reagentStatus = null;
            List<ReagentCollectMess> collectMessList = req.getCollectMessList();

            if (collectMessList == null) {
                //??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
                collectMessList = stockDetailDao.getReloList(collectNo);
            }
            if (qrList == null) {
                qrList = new ArrayList<>();
                //??????????????????qrList???????????????codeValue
                for (ReagentCollectMess collectMess : collectMessList) {
                    List<String> qrs = new ArrayList<>();
                    List<String> codeValues = new ArrayList<>();
                    List<String> codes = new ArrayList<>();
                    String qr;
                    String value;
                    String code;
                    List<ReagentCollectMess> indexValue = stockDetailDao.searchThreeValue(collectNo, collectMess.getReagentId(), collectMess.getBatchNo());

                    //??????????????????????????????for????????????????????????mess?????????????????????
                    for (ReagentCollectMess index : indexValue) {
                        qr = index.getQrCode();
                        value = index.getCodeValue();
                        code = index.getReagentCode();

                        qrs.add(qr);
                        codeValues.add(value);
                        codes.add(code);
                        qrList.add(qr);
                    }
                    collectMess.setQrCodeValueList(codeValues);
                    collectMess.setQrList(qrs);
                    collectMess.setReagentCodeList(codes);
                }
            }

            Date timeNow = new Date();

            Long time1 = new Date().getTime();
            Random ne2 = new Random();//???????????????random?????????ne
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
            String random_order2 = String.valueOf(x2);
            String billCode = time1 + random_order2;

            if (applyInType.equals("0")) {
                // ??????????????????,?????????????????????
                collectStatus = "2";
                reagentStatus = "1997";

                // ??????????????????
                ReagentOutBill outBill1 = new ReagentOutBill();
                outBill1.setBillType(outType);
                outBill1.setBillDate(timeNow);
                outBill1.setBillCreator(req.getCreateBy());

                branch = adminDao.selectBranch(req.getCreateBy());
                outBill1.setBranchName(branch);
                outBill1.setBillStatus(BillStatus.real.getValue());    // ???????????????0-?????????1-?????????
                outBill1.setApplicationUser(req.getApplyMan());
                outBill1.setApplicationDate(timeNow);
                outBill1.setCreateBy(req.getCreateBy());
                outBill1.setCreateTime(timeNow);
                outBill1.setUpdateBy(req.getCreateBy());
                outBill1.setUpdateTime(timeNow);
                outBill1.setBillCode(billCode);

                outBillMapper.insert(outBill1);

                // ?????????????????????????????????????????????
                String applyBranch = adminDao.selectBranch(req.getApplyMan());
                stockDetailDao.updateFetchBranch(applyBranch, qrList);

            } else if (applyInType.equals("1")) {
                //?????????????????????????????????
                collectStatus = "3";
                reagentStatus = "1998";

                // ??????????????????
                ReagentInBill inBill = new ReagentInBill();
                inBill.setBillCode(billCode);
                inBill.setBillType(inType);
                inBill.setCreateType(createType);

                inBill.setBillDate(timeNow);
                inBill.setBillCreator(req.getUsername());

                branch = adminDao.selectBranch(req.getUsername());
                inBill.setBranch(branch);
                inBill.setBillStatus(req.getCollectState());
                inBill.setCreateTime(timeNow);
                inBill.setCreateBy(req.getUsername());
                inBill.setUpdateBy(req.getUsername());
                inBill.setUpdateTime(timeNow);

                inBillMapper.insert(inBill);
            }
            /**
             * ???????????????????????????
             */
            List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();
            List<ReagentOutDetail> reagentOutDetailList = new ArrayList<>();

            collectMessList.forEach(collectMessItem -> {
                ReagentOutDetail outDetail = new ReagentOutDetail();
                ReagentInBillDetail inDetail = new ReagentInBillDetail();

                Long time2 = new Date().getTime();
                Random ne3 = new Random();//???????????????random?????????ne
                int x3 = ne3.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                String random_order3 = String.valueOf(x3);
                String detailId = time2 + random_order3;

                double inTotal = collectMessItem.getReagentPrice() * collectMessItem.getQuantity();

                if (applyInType.equals("0")) {
                    // ??????????????????,?????????????????????
                    outDetail.setBillCode(billCode);
                    outDetail.setOutDetailId(detailId);
                    outDetail.setReagentId(collectMessItem.getReagentId());
                    outDetail.setReagentName(collectMessItem.getReagentName());
                    outDetail.setReagentSpecification(collectMessItem.getReagentSpecification());
                    outDetail.setReagentUnit(collectMessItem.getReagentUnit());
                    outDetail.setBatchNo(collectMessItem.getBatchNo());
                    outDetail.setFactory(collectMessItem.getManufacturerName());
                    outDetail.setPrice(collectMessItem.getReagentPrice());
                    outDetail.setTotal(inTotal);
                    outDetail.setRegistrationNo(collectMessItem.getRegistrationNo());
                    outDetail.setSupplierShortName(collectMessItem.getSupplierShortName());
                    outDetail.setQuantity(collectMessItem.getQuantity());
                    outDetail.setCreateTime(timeNow);
                    outDetail.setCreateBy(req.getCreateBy());
                    outDetail.setApplicationUser(req.getApplyMan());
                    outDetail.setExpireDate(collectMessItem.getExpireDate());
                    outDetail.setUpdateBy(req.getCreateBy());
                    outDetail.setUpdateTime(timeNow);

                    // start: ??????????????????
                    List<ReagentOutDetailItem> reagentOutDetailItemsList = new ArrayList<>();
                    for (int i = 0; i < collectMessItem.getQuantity(); i++) {
                        ReagentOutDetailItem item = new ReagentOutDetailItem();
                        item.setBillCode(billCode);
                        item.setOutDetailId(detailId);
                        item.setCreateTime(timeNow);
                        item.setCreateBy(req.getCreateBy());
                        item.setReagentCode(collectMessItem.getReagentCodeList().get(i));
                        item.setQrCode(collectMessItem.getQrList().get(i));
                        item.setCodeValue(collectMessItem.getQrCodeValueList().get(i));
                        reagentOutDetailItemsList.add(item);
                    }
                    // end?????????????????????

                    reagentOutDetailList.add(outDetail);
                    outDetailItemDao.insertItem(reagentOutDetailItemsList);

                } else if (applyInType.equals("1")) {
                    inDetail.setBillCode(billCode);
                    inDetail.setInDetailId(detailId);
                    inDetail.setReagentId(collectMessItem.getReagentId());
                    inDetail.setReagentName(collectMessItem.getReagentName());
                    inDetail.setReagentUnit(collectMessItem.getReagentUnit());
                    inDetail.setReagentSpecification(collectMessItem.getReagentSpecification());
                    inDetail.setFactory(collectMessItem.getManufacturerName());
                    inDetail.setPrice(collectMessItem.getReagentPrice());
                    inDetail.setQuantity(collectMessItem.getQuantity());
                    inDetail.setTotal(inTotal);
                    inDetail.setBatchNo(collectMessItem.getBatchNo());
                    inDetail.setExpireDate(collectMessItem.getExpireDate());
                    inDetail.setCreateBy(req.getUsername());
                    inDetail.setCreateTime(timeNow);
                    inDetail.setUpdateBy(req.getUsername());
                    inDetail.setUpdateTime(timeNow);

                    // start: ??????????????????
                    List<ReagentInDetailItem> inDetailItemList = new ArrayList<>();
                    for (int i = 0; i < collectMessItem.getQuantity(); i++) {
                        ReagentInDetailItem item = new ReagentInDetailItem();
                        item.setBillCode(billCode);
                        item.setInDetailId(detailId);
                        item.setCreateTime(timeNow);
                        item.setCreateBy(req.getCreateBy());
                        item.setReagentCode(collectMessItem.getReagentCodeList().get(i));
                        item.setQrCode(collectMessItem.getQrList().get(i));
                        item.setCodeValue(collectMessItem.getQrCodeValueList().get(i));
                        item.setStatus("1");
                        inDetailItemList.add(item);
                    }

                    // end?????????????????????
                    reagentInDetailList.add(inDetail);
                    inItemDao.insertBillItem(inDetailItemList);
                }
            });

            if (reagentOutDetailList.size() > 0) {
                outDetailDao.insertOutDetail(reagentOutDetailList);
            }
            if (reagentInDetailList.size() > 0) {
                inDetailDao.insertInDetail(reagentInDetailList);
            }

            // ???????????????????????????
            // 0 ????????????1???????????????2?????????????????????3??????????????????
            collectDao.updateByCN(collectNo, collectStatus);

            // ????????????????????????
            // 1997??????????????????????????????????????????????????????
            // 1998???????????????????????????
            stockDetailDao.updateFetchStatus(reagentStatus, qrList, collectNo);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return 1;
    }

    /**
     * pda ?????? - ????????????
     */
    @Override
    public Integer createCollectPdaByOneKey(ReagentCollectPDAReq req, String billCreator) {
        String stockType = req.getStockType();
        String preInBillCode = req.getPreInBillCode();
        String branchCode = req.getBranchCode();

        //?????????????????????
        String billTypeCenter = "2";    // ????????????
        String billType = "3";      //????????????
        String createTypeToCenter = "4";    // ??????????????????
        String createType = "5";    // ???????????????
        String billStatus = "1";    // 0-?????????1-??????

        //?????????????????????
        String applyInType = "2";    //???????????????
        String collectStatus = "3";  //???????????????

        //?????????????????????
        String outType = "3";    //?????????????????????

        //????????????????????????
        String reagentStatus = "1998";

        ReagentBranchExample exampleBranch = new ReagentBranchExample();
        exampleBranch.createCriteria().andBranchCodeEqualTo(branchCode);
        List<ReagentBranch> branchSet = reagentBranchMapper.selectByExample(exampleBranch);
        String branchName = "";

        if (branchSet.size() > 0) {
            branchName = branchSet.get(0).getBranchName();
        } else {
            branchName = null;
            return 0;
        }

        // ??????????????????????????????
        String branchAdminName = null;
        Long branchAdminId = null;

        /*
            1. ??????????????????????????????????????????
            2. ?????????????????????id?????????roleId?????????3???????????????????????????
            3. ??????????????????????????????
         */
        ReagentAdminExample exampleAdmin = new ReagentAdminExample();
        exampleAdmin.createCriteria().andBranchEqualTo(branchName);
        List<ReagentAdmin> userSet = reagentAdminMapper.selectByExample(exampleAdmin);
        if (userSet.size() > 0) {
            for (ReagentAdmin user : userSet) {
                Long userId = user.getId();
                ReagentAdminRoleRelationExample exampleRoleRelation = new ReagentAdminRoleRelationExample();
                exampleRoleRelation.createCriteria().andAdminIdEqualTo(userId);
                List<ReagentAdminRoleRelation> roleIdSet = reagentAdminRoleRelationMapper.selectByExample(exampleRoleRelation);
                // ????????? - ???????????????
                if (roleIdSet.get(0).getRoleId() == 3) {
                    branchAdminName = user.getUsername();
                    branchAdminId = userId;
                    break;
                }
            }
        }

        // ??????????????????????????????
        if (branchAdminName == null) {
            System.out.println("[Error]:::??????????????????????????????");
            return 0;
        }

        //?????????????????????-?????????
        String creatorId = adminService.getAdminByUsername(billCreator).getId().toString();
        String userBranch = adminDao.selectBranch(billCreator);

        try {
            Long time1 = new Date().getTime();
            Random ne2 = new Random();  // ???????????????random?????????ne
            Random ne22 = new Random();
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;  // ?????????????????????100-999
            int x22 = ne22.nextInt(999 - 100 + 1) + 100;
            String random_order2 = String.valueOf(x2);
            String random_order22 = String.valueOf(x22);
            // ??????????????????
            String billCode = time1 + random_order2;    // ????????????
            String billCode2 = time1 + random_order22;  // ????????????
            Date timeNow = new Date();

            //???????????????????????????
            ReagentPreInBill preInBill = preInBillDao.selectByBillCode(preInBillCode);
            List<ReagentPreInDetail> preInDetailList = preInDetailDao.selectByBillCode(preInBillCode);

            // start: ??????????????????
            ReagentOutBill outBill = new ReagentOutBill();
            outBill.setBillCode(billCode2);
            outBill.setBillType(outType);
            outBill.setBillDate(timeNow);
            outBill.setBillCreator(billCreator);
            outBill.setBranchName(userBranch);  // ???????????????
            outBill.setBillStatus(BillStatus.real.getValue());    // ???????????????0-?????????1-?????????
            outBill.setApplicationUser(branchAdminName);  // ????????? - ???????????????
            outBill.setApplicationDate(timeNow);
            outBill.setCreateBy(billCreator);
            outBill.setCreateTime(timeNow);
            outBill.setUpdateBy(billCreator);
            outBill.setUpdateTime(timeNow);

            outBillMapper.insert(outBill);
            // end: ??????????????????

            /*
                start: ??????????????????
                ??????????????????????????????????????????????????????????????????
             */
            ReagentInBillVm inBillAll = new ReagentInBillVm();
            // ????????????
            inBillAll.setBillCode(billCode);
            inBillAll.setPreInBillCode(null);
            inBillAll.setBillType(billType);
            inBillAll.setCreateType(createType);
            inBillAll.setSupplierId(preInBill.getSupplierId());
            inBillAll.setSupplierShortName(preInBill.getSupplierShortName());
            inBillAll.setBillDate(timeNow);
            inBillAll.setBillStatus(billStatus);
            inBillAll.setBranch(branchName);
            inBillAll.setBillCreator(branchAdminName);
            inBillAll.setRemark(null);
            inBillAll.setCreateBy(branchAdminName);
            inBillAll.setCreateTime(timeNow);
            // ????????????????????????
            inBillAll.setUpdateBy(billCreator);
            inBillAll.setUpdateTime(timeNow);

            inBillDao.insert(inBillAll);

            // ????????????
            inBillAll.setBillCode(billCode2);
            inBillAll.setPreInBillCode(preInBillCode);
            inBillAll.setBillType(billTypeCenter);
            inBillAll.setCreateType(createTypeToCenter);
            inBillAll.setBranch(userBranch);
            inBillAll.setBillCreator(billCreator);
            inBillAll.setCreateBy(billCreator);

            inBillDao.insert(inBillAll);
            /*
                end: ??????????????????
             */

            // start: ??????????????????
            ReagentCollect collectItem = new ReagentCollect();
            collectItem.setCollectStatus(collectStatus);
            collectItem.setCollectDay(timeNow);
            collectItem.setApplyType(applyInType);
            collectItem.setCollectDescribe(null);
            collectItem.setCreateName(branchAdminName); // ????????????????????????
            collectItem.setCreateTime(timeNow);
            collectItem.setBranch(branchName);
            collectItem.setUpdateBy(billCreator);   // ??????????????????
            collectItem.setUpdateTime(timeNow);
            Random collectRd = new Random();//???????????????random?????????ne
            int collectIndex = collectRd.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
            String collectRandom2 = String.valueOf(collectIndex);
            String collectNo = timeNow.getTime() + collectRandom2;
            collectItem.setCollectNo(collectNo);

            collectMapper.insert(collectItem);
            // end: ??????????????????

            List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();  // ?????????????????????
            List<ReagentInBillDetail> reagentInDetailCenterList = new ArrayList<>();    // ????????????????????????
            List<ReagentOutDetail> outDetailList = new ArrayList<>();
            List<ReagentCollectDetail> collectDetailList = new ArrayList<>();
            List<ReagentPreInDetailItem> preInItemList = new ArrayList<>();

            // ????????????2???3???????????????1???2???
            for (ReagentPreInDetail pid : preInDetailList) {

                // ???????????? detail??????????????? ?????????????????????
                if (pid.getBillStatus().equals("1")) {
                    continue;
                }

                ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
                ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
                criteria.andCodeEqualTo(pid.getReagentCode());
                List<ReagentBaseInfo> baseInfoList = baseInfoMapper.selectByExample(baseInfoExample);
                ReagentBaseInfo baseInfo = baseInfoList.get(0);

                // start: ????????????????????????????????????
                // start: ??????????????????
                ReagentInBillDetail inDetail = new ReagentInBillDetail();
                ReagentInBillDetail inDetailCenter = new ReagentInBillDetail();

                Long time2 = new Date().getTime();
                Random ne3 = new Random();  // ???????????????random?????????ne
                int x3 = ne3.nextInt(999 - 100 + 1) + 100;  // ?????????????????????100-999
                int x33 = ne3.nextInt(999 - 100 + 1) + 100;
                String random_order3 = String.valueOf(x3);
                String random_order33 = String.valueOf(x33);
                String inDetailId = time2 + random_order3;
                String inDetailIdCenter = time2 + random_order33;

                // ????????????????????????
                inDetail.setBillCode(billCode);
                inDetail.setInDetailId(inDetailId);
                inDetail.setTotal(pid.getTotal());
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
                inDetail.setCreateBy(branchAdminName);
                inDetail.setCreateTime(timeNow);

                // ???????????????????????????
                inDetailCenter.setBillCode(billCode2);
                inDetailCenter.setInDetailId(inDetailIdCenter);
                inDetailCenter.setTotal(pid.getTotal());
                inDetailCenter.setReagentId(pid.getReagentCode());
                inDetailCenter.setReagentName(pid.getReagentName());
                inDetailCenter.setReagentUnit(pid.getReagentUnit());
                inDetailCenter.setReagentSpecification(pid.getReagentSpecification());
                inDetailCenter.setFactory(pid.getFactory());
                inDetailCenter.setPrice(pid.getPrice());
                inDetailCenter.setQuantity(pid.getQuantity());
                inDetailCenter.setBatchNo(pid.getBatchNo());
                inDetailCenter.setExpireDate(pid.getExpireDate());
                inDetailCenter.setRemark(null);
                inDetailCenter.setCreateBy(billCreator);
                inDetailCenter.setCreateTime(timeNow);

                reagentInDetailList.add(inDetail);
                reagentInDetailCenterList.add(inDetailCenter);
                // end: ??????????????????

                // start:??????????????????
                ReagentCollectDetail collectDetail = new ReagentCollectDetail();
                collectDetail.setCollectNo(collectNo);
                collectDetail.setReagentCode(pid.getReagentCode());
                collectDetail.setReagentName(pid.getReagentName());
                //???????????????????????????
                //collectDetail.setSupplierShortName(baseInfo.getSupplierShortName());
                collectDetail.setSupplierShortName(preInBill.getSupplierShortName());
                collectDetail.setFactory(pid.getFactory());
                collectDetail.setUnit(pid.getReagentUnit());
                collectDetail.setReagentType(pid.getReagentSpecification());
                collectDetail.setPrice(pid.getPrice());
                collectDetail.setReagentNumber(pid.getQuantity());
                collectDetail.setCreateTime(timeNow);
                collectDetail.setCreateBy(branchAdminName);
                collectDetail.setUpdateBy(billCreator); // ??????????????????
                collectDetail.setUpdateTime(timeNow);
                collectDetailList.add(collectDetail);
                // end: ??????????????????

                // start: ??????????????????
                ReagentOutDetail outDetail = new ReagentOutDetail();
                outDetail.setBillCode(billCode2);   // ???????????????????????????
                outDetail.setOutDetailId(inDetailIdCenter); // ????????????????????????
                outDetail.setReagentId(pid.getReagentCode());
                outDetail.setReagentName(pid.getReagentName());
                outDetail.setReagentSpecification(pid.getReagentSpecification());
                outDetail.setReagentUnit(pid.getReagentUnit());
                outDetail.setBatchNo(pid.getBatchNo());
                outDetail.setFactory(pid.getFactory());
                outDetail.setPrice(pid.getPrice());
                double inTotal = pid.getPrice() * pid.getQuantity();
                outDetail.setTotal(inTotal);
                outDetail.setRegistrationNo(baseInfo.getRegistrationNo());
                //???????????????????????????
                //outDetail.setSupplierShortName(baseInfo.getSupplierShortName());
                outDetail.setSupplierShortName(preInBill.getSupplierShortName());
                outDetail.setQuantity(pid.getQuantity());
                outDetail.setCreateTime(timeNow);
                outDetail.setCreateBy(billCreator);
                outDetail.setApplicationUser(branchAdminName);
                outDetail.setExpireDate(pid.getExpireDate());
                outDetail.setUpdateBy(billCreator);
                outDetail.setUpdateTime(timeNow);

                outDetailList.add(outDetail);
                // end: ??????????????????

                // start: ???????????????
                ReagentStock reagentStock = new ReagentStock();
                List<ReagentStock> reagentStockList = stockDao.selectByReagentId(pid.getReagentCode());

                String stockNo;

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
                    reagentStock.setBranchName(branchName);
                    reagentStock.setFactory(pid.getFactory());
                    reagentStock.setSupplierName(preInBill.getSupplierShortName());
                    reagentStock.setQuantity(pid.getQuantity());
                    reagentStock.setReagentPrice(pid.getPrice());
                    reagentStock.setReagentStatus(billStatus);
                    reagentStock.setReagentTemp(baseInfo.getStockType());
                    reagentStock.setLowStock(baseInfo.getStockLimit().toString());
                    reagentStock.setOverdue(baseInfo.getExpirationLimit());
                    reagentStock.setCreateBy(creatorId);    // ??????????????????
                    reagentStock.setCreateTime(timeNow);
                    assert branchAdminId != null;
                    reagentStock.setUpdateBy(branchAdminId.toString());
                    reagentStock.setUpdateTime(timeNow);

                    stockMapper.insert(reagentStock);
                }
                //end: ????????????????????????????????????

                //start: ????????????????????????????????????
                List<ReagentInDetailItem> reagentInDetailItemList = new ArrayList<>();  // ????????????????????????
                List<ReagentInDetailItem> reagentInDetailItemCenterList = new ArrayList<>();    // ????????????????????????
                List<ReagentStockDetail> reagentStockDetailList = new ArrayList<>();
                List<ReagentOutDetailItem> reagentOutDetailItemList = new ArrayList<>();

                preInItemList = preInItemDao.selectByInDetailId(pid.getInDetailId());

                for (ReagentPreInDetailItem pidi : preInItemList) {
                    // start: ??????????????????
                    ReagentInDetailItem item = new ReagentInDetailItem();   // ??????????????????
                    ReagentInDetailItem itemCenter = new ReagentInDetailItem(); // ??????????????????

                    // ????????????????????????
                    item.setBillCode(billCode);
                    item.setInDetailId(inDetailId);
                    item.setStatus(billStatus);
                    item.setQrCode(pidi.getQrCode());
                    item.setCodeValue(pidi.getCodeValue());
                    item.setReagentCode(pidi.getReagentCode());
                    item.setCreateTime(timeNow);
                    item.setCreateBy(branchAdminName);

                    // ????????????????????????
                    itemCenter.setBillCode(billCode2);
                    itemCenter.setInDetailId(inDetailIdCenter);
                    itemCenter.setStatus(billStatus);
                    itemCenter.setQrCode(pidi.getQrCode());
                    itemCenter.setCodeValue(pidi.getCodeValue());
                    itemCenter.setReagentCode(pidi.getReagentCode());
                    itemCenter.setCreateBy(billCreator);
                    itemCenter.setCreateTime(timeNow);

                    reagentInDetailItemList.add(item);
                    reagentInDetailItemCenterList.add(itemCenter);
                    // end: ??????????????????

                    // start: ??????????????????
                    ReagentOutDetailItem outItem = new ReagentOutDetailItem();
                    outItem.setBillCode(billCode2);
                    outItem.setOutDetailId(inDetailIdCenter);
                    outItem.setCreateTime(timeNow);
                    outItem.setCreateBy(billCreator);
                    outItem.setReagentCode(pidi.getReagentCode());
                    outItem.setQrCode(pidi.getQrCode());
                    outItem.setCodeValue(pidi.getCodeValue());
                    outItem.setUpdateBy(billCreator);
                    outItem.setUpdateTime(timeNow);
                    reagentOutDetailItemList.add(outItem);
                    // end?????????????????????

                    // start: ???????????????
                    ReagentStockDetail reagentStockDetail = new ReagentStockDetail();

                    reagentStockDetail.setStockNo(stockNo);
                    reagentStockDetail.setStockType(stockType);
                    reagentStockDetail.setCollectNo(collectNo);
                    reagentStockDetail.setReagentId(pid.getReagentCode());
                    reagentStockDetail.setReagentName(baseInfo.getName());
                    reagentStockDetail.setSpecification(baseInfo.getSpecification());
                    reagentStockDetail.setManufacturerName(baseInfo.getManufacturerName());
                    reagentStockDetail.setRegistrationNo(baseInfo.getRegistrationNo());
                    //???????????????????????????
                    //reagentStockDetail.setSupplierShortName(baseInfo.getSupplierShortName());
                    reagentStockDetail.setSupplierShortName(preInBill.getSupplierShortName());
                    reagentStockDetail.setBranch(branchName);   // ??????
                    reagentStockDetail.setReagentUnit(baseInfo.getUnit());
                    reagentStockDetail.setReagentStatus(reagentStatus);
                    reagentStockDetail.setReagentTemp(baseInfo.getStockType());
                    reagentStockDetail.setCreateBy(creatorId);  // ????????????ID
                    reagentStockDetail.setCreateTime(timeNow);
                    assert branchAdminId != null;
                    reagentStockDetail.setUpdateBy(branchAdminId.toString());   // ????????????ID
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
                    reagentStockDetail.setEnterNo(billCode2);   // ??????????????????
                    reagentStockDetail.setEnterMan(billCreator);    // ???????????? username

                    reagentStockDetailList.add(reagentStockDetail);
                    // end: ???????????????
                }

                //end: ????????????????????????????????????
                inDetailItemDao.insertBillItem(reagentInDetailItemList);
                inDetailItemDao.insertBillItem(reagentInDetailItemCenterList);
                stockDetailDao.insertStockDetail(reagentStockDetailList);
                outDetailItemDao.insertItem(reagentOutDetailItemList);
            }

            inDetailDao.insertInDetail(reagentInDetailList);
            inDetailDao.insertInDetail(reagentInDetailCenterList);
            collectDetailDao.insertCollectDetail(collectDetailList);
            outDetailDao.insertOutDetail(outDetailList);

            // ????????????????????????
            String qrCodeRandom = preInItemList.get(0).getQrCode();
            String preBillCode = null;
            if (qrCodeRandom != null) {
                preBillCode = preInItemDao.getPreCode(qrCodeRandom);
            }
            if (preBillCode != null) {
                preInBillDao.updateStatus(preBillCode, billStatus);
                preInDetailDao.updateStatus(preBillCode, billStatus);
                preInItemDao.updateStatus(preBillCode, billStatus);

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
                orderDao.updateByON(preBillCode, orderStatus);
            }

            //???????????????????????????
            //??????????????????????????????????????????-?????????????????????-????????????
            /*List<ReagentStock> stockListAll = stockDao.selectByBranch(stockType, null, null, null, null, userBranch);
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
            }*/

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }

    @Override
    public int changeStatus(Long id) {
        return collectMapper.changeStatus(id);
    }

    @Override
    public List<ReagentCollect> getAllByApplyType(String applyType) {

        return collectDao.getAllByApplyType(applyType);
    }

    /**
     * ??????????????????
     *
     * @param id
     * @param collect
     */
    @Override
    public int update(Long id, ReagentCollect collect) {
        collect.setId(id);
        return collectMapper.updateByPrimaryKeySelective(collect);
    }

    /**
     * ???????????????????????????????????????
     *
     * @param collectNo
     * @param collect
     */
    @Override
    public int updateByCN(String collectNo, ReagentCollect collect) {
        String collectStatus = collect.getCollectStatus();
        return collectDao.updateByCN(collectNo, collectStatus);
    }

    /**
     * ??????????????????
     *
     * @param ids
     */

    @Override
    public int delete(List<Long> ids) {
        ReagentCollectExample example = new ReagentCollectExample();
        example.createCriteria().andIdIn(ids);
        int count = collectMapper.deleteByExample(example);
        return count;
    }

    /**
     * ????????????????????????
     *
     * @param applyType
     * @param pageSize
     * @param pageNum
     */
    @Override
    public List<ReagentCollect> list(String applyType, String keyword, String username, Integer pageSize, Integer pageNum) {
        String branch = adminDao.selectBranch(username);
        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        PageHelper.startPage(pageNum, pageSize);
        String collectStatus;
        // ??????????????????-?????????2?????????????????????-?????????3??????1 and 0 ????????????
        // ??????????????????6???????????? 0 ??????
        // ???????????????4????????????????????????9 ????????????1??????????????????
        if (roleId == 2 || roleId == 3) {
            return collectDao.selectByBranch(applyType, keyword, branch, null, "");
        } else if (roleId == 6) {
            return collectDao.selectByBranch(applyType, keyword, null, null, "0");
        } else if (roleId == 4 || roleId == 9) {
            collectStatus = "1";
            return collectDao.selectByBranch(applyType, keyword, null, collectStatus, "");
        } else {
            return collectDao.searchList(applyType, keyword);
        }

    }

    /**
     * @param id
     * @return
     */
    @Override
    public ReagentCollect getItem(Long id) {

        return collectMapper.selectByPrimaryKey(id);
    }

    /**
     * @param collectNo
     * @return
     */
    public int deleteByCollectNo(String collectNo) {
        ReagentCollectExample example = new ReagentCollectExample();
        example.createCriteria().andCollectNoEqualTo(collectNo);
        int count = collectMapper.deleteByExample(example);
        return count;
    }

    /**
     * ??????????????????
     */
    @Override
    public List<ReagentStatus> countCollect(String username, String startTime, String endTime, Integer pageSize, Integer pageNum) {
        //String groupName = adminDao.selectGroupName(username);
        PageHelper.startPage(pageNum, pageSize);
        List<ReagentStatus> collectList = collectDao.countCollect(startTime, endTime);
        return collectList;
    }

}