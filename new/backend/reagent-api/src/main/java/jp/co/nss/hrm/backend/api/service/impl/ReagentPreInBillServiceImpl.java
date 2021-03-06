package jp.co.nss.hrm.backend.api.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.*;
import jp.co.nss.hrm.backend.api.dto.ReagentItem;
import jp.co.nss.hrm.backend.api.dto.ReagentPreInBillMess;
import jp.co.nss.hrm.backend.api.dto.ReagentPreInBillPost;
import jp.co.nss.hrm.backend.api.service.ReagentPreInBillService;
import jp.co.nss.hrm.backend.mapper.*;
import jp.co.nss.hrm.backend.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class ReagentPreInBillServiceImpl implements ReagentPreInBillService {

    @Autowired
    private ReagentPreInBillMapper preInBillMapper;

    @Autowired
    private ReagentPreInDetailMapper preInDetailMapper;

    @Autowired
    private ReagentBaseInfoMapper baseInfoMapper;

    @Autowired
    private ReagentSupplierMapper supplierMapper;

    @Autowired
    private ReagentPreInDetailDao preInDetailDao;

    @Autowired
    private ReagentPreInDetailItemDao preInDetailItemDao;

    @Autowired
    private ReagentPreInBillDao preInBillDao;

    @Autowired
    private ReagentAdminDao adminDao;

    @Autowired
    private ReagentAdminRoleRelationDao adminRoleDao;

    @Autowired
    private ReagentOrderDao orderDao;

    @Autowired
    private ReagentOrderDetailMapper orderDetailMapper;

    @Autowired
    private ReagentInBillDao inBillDao;

    @Autowired
    private ReagentOutBillDao outBillDao;

    @Autowired
    private ReagentOrderDetailDao orderDetailDao;

    @Autowired
    private ReagentStockDetailDao stockDetailDao;

    @Autowired
    private ReagentCollectDao collectDao;

    @Autowired
    private ReagentRefundDao refundDao;

    /**
     * ??????????????????????????????
     */
    @Override
    public List<ReagentPreInBill> list() {

        return preInBillMapper.selectByExample(new ReagentPreInBillExample());
    }

    /**
     * ??????????????????
     *
     * @param preInBill
     */

    @Override
    public int create(ReagentPreInBillPost preInBill) {
        String billStatus = preInBill.getBillStatus();
        String billType = preInBill.getBillType();
        String orderNo = preInBill.getOrderNo();
        List<ReagentPreInBillMess> preInBillMessList = preInBill.getPreInBillMessList();
        List<String> baseInfos = new ArrayList<>();

        preInBillMessList.forEach(item -> {
            baseInfos.add(item.getCode());
        });

        // ?????????????????????????????????????????????
        ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
        ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
        criteria.andCodeIn(baseInfos);
        // ??????????????????????????????
        List<ReagentBaseInfo> baseInfoDetailList = baseInfoMapper.selectByExample(baseInfoExample);

        //??????orderNo?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        //?????????????????????????????????????????????????????????????????????????????????
        List<ReagentPreInDetail> judgePreDetail;
        ReagentPreInDetailExample preInDetailExample = new ReagentPreInDetailExample();
        preInDetailExample.createCriteria().andBillCodeEqualTo(orderNo);
        judgePreDetail = preInDetailMapper.selectByExample(preInDetailExample);
        int isPreDone = 0;
        AtomicInteger isPreDetailDone = new AtomicInteger();
        try {
            // ??????????????????
            ReagentPreInBill preInBillItem = new ReagentPreInBill();
            if (judgePreDetail.isEmpty()) {
                //???????????????ID
                String supplierID;
                ReagentSupplierExample supplierExample = new ReagentSupplierExample();
                ReagentSupplierExample.Criteria criteria1 = supplierExample.createCriteria();
                criteria1.andSupplierShortNameEqualTo(preInBillMessList.get(0).getSupplierShortName());
                List<ReagentSupplier> supplierList = supplierMapper.selectByExample(supplierExample);
                supplierID = supplierList.get(0).getSupplierCode();

                preInBillItem.setSupplierId(supplierID);
                preInBillItem.setSupplierShortName(preInBillMessList.get(0).getSupplierShortName());
                preInBillItem.setBillDate(new Date());
                preInBillItem.setBillType(billType);
                preInBillItem.setRemark(preInBill.getRemark());
                preInBillItem.setBillCreator(preInBill.getBillCreator());

                preInBillItem.setBillCode(orderNo);
                preInBillItem.setCreateTime(new Date());
                preInBillItem.setBillStatus("2");
                isPreDone = preInBillMapper.insert(preInBillItem);
            } else {
                //??????????????????????????????????????????????????????
                String status = "2";
                preInBillDao.updateStatus(orderNo, status);
            }

            // ???????????????????????????
            List<ReagentPreInDetail> reagentPreInDetailList = new ArrayList<>();
            preInBillMessList.forEach(preBillItem -> {
                baseInfoDetailList.forEach(baseInfoItem -> {
                    if (preBillItem.getCode().equals(baseInfoItem.getCode())) {
                        //???????????????????????????ID
                        Long time1 = new Date().getTime();
                        Random ne2 = new Random();//???????????????random?????????ne
                        int x2 = ne2.nextInt(999 - 100 + 1) + 100;//?????????????????????100-999
                        String random_order2 = String.valueOf(x2);
                        String inDetailId = time1 + random_order2;

                        ReagentPreInDetail preInDetail = new ReagentPreInDetail();
                        preInDetail.setBillCode(orderNo);
                        preInDetail.setReagentUnit(baseInfoItem.getUnit());
                        preInDetail.setInDetailId(inDetailId);
                        preInDetail.setReagentCode(baseInfoItem.getCode());
                        preInDetail.setReagentName(baseInfoItem.getName());
                        preInDetail.setReagentSpecification(baseInfoItem.getSpecification());
                        preInDetail.setFactory(preBillItem.getFactory());
                        preInDetail.setQuantity(preBillItem.getQuantity().longValue());

                        double totalPrice = preBillItem.getPrice() * preBillItem.getQuantity();
                        preInDetail.setTotal(totalPrice);
                        preInDetail.setPrice(preBillItem.getPrice());
                        preInDetail.setBatchNo(preBillItem.getBatchNo());
                        preInDetail.setExpireDate(preBillItem.getExpireDate());
                        preInDetail.setBillStatus(billStatus);
                        preInDetail.setRemark(preInBill.getRemark());
                        preInDetail.setCreateTime(new Date());
                        isPreDetailDone.set(preInDetailMapper.insert(preInDetail));
                        //reagentPreInDetailList.add(preInDetail);

                        // ???????????????????????????
                        List<ReagentPreInDetailItem> reagentPreInDetailItemList = new ArrayList<>();

                        //???????????????????????????????????????
                        Date expireDate = preBillItem.getExpireDate();
                        String expireDateFormat = String.format("%tY", expireDate) + "-" +
                                String.format("%tm", expireDate) + "-" +
                                String.format("%td", expireDate);

                        String reagentId = baseInfoItem.getCode();
                        String batchNo = preBillItem.getBatchNo();

                        String stockCount = stockDetailDao.countBatchNo(reagentId, batchNo);
                        String preCount = preInDetailDao.countBatchNo(reagentId, batchNo);
                        int numCount;
                        if (stockCount == null) stockCount = "0";
                        if (preCount == null) preCount = "0";
                        numCount = Integer.parseInt(stockCount) + Integer.parseInt(preCount);

                        for (int i = numCount + 1; i <= numCount + preBillItem.getQuantity(); i++) {
                            ReagentPreInDetailItem reagentPreInDetailItem = new ReagentPreInDetailItem();
                            reagentPreInDetailItem.setBillCode(orderNo);
                            reagentPreInDetailItem.setCreateTime(new Date());
                            reagentPreInDetailItem.setInDetailId(inDetailId);
                            String sort;

                            if (preBillItem.getQuantity() < 1000) {
                                if (i < 10) {
                                    sort = "00" + i;
                                } else if (i < 100) {
                                    sort = "0" + i;
                                } else {
                                    sort = Integer.toString(i);
                                }
                            } else if (preBillItem.getQuantity() < 10000) {
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
                            String reagentCode = preBillItem.getBatchNo() + sort;
                            reagentPreInDetailItem.setReagentCode(reagentCode);
                            reagentPreInDetailItem.setCreateBy(preInBill.getBillCreator());
                            reagentPreInDetailItem.setStatus(billStatus);

                            //?????????????????????
                            String codeValue = "??????: " + baseInfoItem.getName() +
                                    "<br/>??????: " + preBillItem.getFactory() +
                                    "<br/>?????????: " + preBillItem.getSupplierShortName() +
                                    "<br/>??????: " + preBillItem.getBatchNo() +
                                    "<br/>?????????: " + expireDateFormat +
                                    "<br/>??????: " + reagentCode;

                            String qrCode = inDetailId + reagentCode;
                            reagentPreInDetailItem.setCodeValue(codeValue);
                            reagentPreInDetailItem.setQrCode(qrCode);

                            reagentPreInDetailItemList.add(reagentPreInDetailItem);
                        }
                        preInDetailItemDao.insertItem(reagentPreInDetailItemList);
                    }
                });
            });

            List<ReagentOrderDetail> orderDetailList = orderDetailDao.selectByOrderNo(orderNo);

            //????????????????????????????????????????????????
            preInBillMessList.forEach(preMessItem -> {
                orderDetailList.forEach(orderItem -> {
                    if (preMessItem.getCode().equals(orderItem.getReagentCode())) {

                        //?????????????????????????????????????????????????????????
                        orderItem.setSendNum(orderItem.getSendNum() + preMessItem.getQuantity());
                        //??????????????????????????????????????????????????????
                        long unSendNum = orderItem.getReagentNumber() - orderItem.getSendNum();
                        orderItem.setUnsendNum(unSendNum);

                        //??????
                        ReagentOrderDetailExample orderDetailExample = new ReagentOrderDetailExample();
                        orderDetailExample.createCriteria().andOrderNoEqualTo(orderNo).andReagentCodeEqualTo(orderItem.getReagentCode());
                        orderDetailMapper.updateByExampleSelective(orderItem, orderDetailExample);
                    }
                });
            });
            //?????????????????????????????????????????????????????????????????????
            //????????????????????????????????????0??????????????????
            AtomicBoolean isComplate = new AtomicBoolean(true);
            List<ReagentOrderDetail> judgeOrderList = orderDetailDao.selectByOrderNo(orderNo);
            for (ReagentOrderDetail orderDetail : judgeOrderList) {
                if (orderDetail.getUnsendNum() != 0) {
                    isComplate.set(false);
                    break;
                }
            }
            String orderStatus;
            //????????????????????????????????????
            if (isComplate.get()) {
                orderStatus = "5";
            } else {
                //??????????????????????????????
                orderStatus = "2";
            }
            orderDao.updateByON(orderNo, orderStatus);

            /*List<String> orderName = new ArrayList<>();
            List<String> orderNumber = new ArrayList<>();
            List<String> preName = new ArrayList<>();
            List<String> preQuantity = new ArrayList<>();

            //???????????????????????????????????????????????????????????????????????????????????????????????????
            List<ReagentPreInDetail> indexDetailList;

            // reagentName???key??? ????????????????????????????????????ReagentPreInDetail??????o1???o2?????????????????????????????????o1???
            // ??????reagentName??????????????????Quantity???o1???????????????o2, ?????????o1???????????????o1
            List<ReagentPreInDetail> preInDetail = new ArrayList<>();
            BeanUtils.copyProperties(reagentPreInDetailList, preInDetail);

            //???????????????????????????????????????????????????????????????
            List<ReagentPreInDetail> preInDetailList = reagentPreInDetailList.stream().map(t -> {
                ReagentPreInDetail preInDetailItem = new ReagentPreInDetail();
                BeanUtils.copyProperties(t, preInDetailItem);
                return preInDetailItem;
            }).collect(Collectors.toList());

            indexDetailList = new ArrayList<>(preInDetailList.stream().collect(Collectors.toMap(ReagentPreInDetail::getReagentCode, a -> a, (o1, o2) -> {
                o1.setQuantity(o1.getQuantity() + o2.getQuantity());
                return o1;
            })).values());

            //???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
            for (ReagentOrderDetail orderDetail : orderDetailList) {
                orderName.add(orderDetail.getReagentCode());
                orderNumber.add(orderDetail.getReagentNumber().toString());
            }
            for (ReagentPreInDetail reagentPreInDetail : indexDetailList) {
                preName.add(reagentPreInDetail.getReagentCode());
                preQuantity.add(reagentPreInDetail.getQuantity().toString());
            }
            //??????list?????????sort????????????????????????????????????toString?????????????????????????????????
            orderName.sort(Comparator.comparing(String::hashCode));
            preName.sort(Comparator.comparing(String::hashCode));
            final boolean nameEquals = orderName.toString().equals(preName.toString());

            orderNumber.sort(Comparator.comparing(String::hashCode));
            preQuantity.sort(Comparator.comparing(String::hashCode));

            System.out.println("orderNumber: " + orderNumber);
            System.out.println("preQuantity: " + preQuantity);

            final boolean numEquals = orderNumber.toString().equals(preQuantity.toString());
            System.out.println("numEquals: " + numEquals);

            int count = 1;
            if (orderDetailList.size() != indexDetailList.size()) {
                //???????????????
                preInBillItem.setBillStatus("4");
                count = 4;
            } else if (nameEquals && !numEquals) {
                //?????????????????????
                preInBillItem.setBillStatus("3");
                count = 3;
            } else if (nameEquals && numEquals) {
                //?????????????????????
                preInBillItem.setBillStatus("2");
                count = 2;
            }

            //??????????????????????????????????????????????????????????????????????????????????????????????????????
            if (count == 2) {
                preInBillMapper.insert(preInBillItem);
                preInDetailDao.insertBach(reagentPreInDetailList);

                //??????????????????????????????
                if (orderNo != null) {
                    String orderStatus = "2";
                    orderDao.updateByON(orderNo, orderStatus);
                }
            } else {
                ReagentPreInDetailItemExample itemExample = new ReagentPreInDetailItemExample();
                itemExample.createCriteria().andBillCodeEqualTo(orderNo);
                preInDetailItemMapper.deleteByExample(itemExample);
            }*/

            //int isPreDetailDone = preInDetailDao.insertBach(reagentPreInDetailList);

            return isPreDone + isPreDetailDone.get();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    /**
     * ????????????
     */
    @Override
    public String fileUpload(MultipartFile file, String inDetailId, int cell) {
        String newFilePath = null;
        try {
            String fileName = file.getOriginalFilename();

            //?????????????????????
            String filePath = System.getProperty("user.dir") + File.separator + "web" + File.separator + "static" + File.separator + "reportFile";
            //??????????????????
            //String filePath = System.getProperty("user.dir") + File.separator + "frontend" + File.separator + "static" + File.separator + "reportFile";

            //?????????????????????
            //newFilePath = File.separator + "static" + File.separator + "reportFile" + File.separator + fileName;
            //??????????????????
            newFilePath = File.separator + "static" + File.separator + "reportFile" + File.separator + fileName;

            switch (cell) {
                case 0:
                    ReagentPreInDetail preInDetail = new ReagentPreInDetail();
                    preInDetail.setUpdateTime(new Date());
                    preInDetail.setReportAddress(newFilePath);
                    ReagentPreInDetailExample preInDetailExample = new ReagentPreInDetailExample();
                    preInDetailExample.createCriteria().andInDetailIdEqualTo(inDetailId);
                    preInDetailMapper.updateByExampleSelective(preInDetail, preInDetailExample);
                    break;
                case 1:
                    ReagentPreInBill preInBill = new ReagentPreInBill();
                    preInBill.setUpdateTime(new Date());
                    preInBill.setElectronicInvoice(newFilePath);
                    ReagentPreInBillExample preInBillExample = new ReagentPreInBillExample();
                    //?????????id??????inDetailId??????????????????????????????????????????id?????????????????????
                    preInBillExample.createCriteria().andIdEqualTo(Long.valueOf(inDetailId));
                    preInBillMapper.updateByExampleSelective(preInBill, preInBillExample);
                    break;
            }

            //??????????????????????????????
            uploadFile(file.getBytes(), filePath, fileName);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return newFilePath;
    }

    public static void uploadFile(byte[] file, String filePath, String fileName) throws Exception {
        File targetFile = new File(filePath);
        if (!targetFile.exists()) {
            boolean wasSuccessful = targetFile.mkdirs();
        }
        filePath += File.separator;
        FileOutputStream out = new FileOutputStream(filePath + fileName);
        out.write(file);
        out.flush();
        out.close();
    }

    /**
     * ????????????????????????
     *
     * @param id
     * @param preInBill
     */
    @Override
    public int update(Long id, ReagentPreInBill preInBill) {
        preInBill.setId(id);
        return preInBillMapper.updateByPrimaryKeySelective(preInBill);
    }

    /**
     * ??????????????????
     *
     * @param ids
     */
    @Override
    public int delete(List<Long> ids) {
        ReagentPreInBillExample example = new ReagentPreInBillExample();
        example.createCriteria().andIdIn(ids);
        return preInBillMapper.deleteByExample(example);
    }

    /**
     * ??????????????????????????????
     *
     * @param keyword
     * @param pageSize
     * @param pageNum
     */
    @Override
    public PageInfo<ReagentPreInBill> list(String keyword, String username, Integer pageSize, Integer pageNum) {

        //??????username???admin??????admin_id
        //??????admin_id???admin_role??????role_id
        //??????role_id??????????????????5?????????????????????2/6
        //if???????????????username???order???????????????????????????????????????????????????
        //else??????????????????????????????
        //???????????????

        //??????Page???
        Page<ReagentPreInBill> page = new Page<>(pageNum, pageSize);
        int total;

        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        List<ReagentPreInBill> preInBillList;
        PageHelper.startPage(pageNum, pageSize);
        if (roleId == 5) {
            String supplier = adminDao.selectSupplier(username);
            ReagentSupplierExample supplierExample = new ReagentSupplierExample();
            supplierExample.createCriteria().andSupplierShortNameEqualTo(supplier);
            List<ReagentSupplier> supplierList = supplierMapper.selectByExample(supplierExample);
            String supplierCode = supplierList.get(0).getSupplierCode();
            preInBillList = preInBillDao.selectBySupplier(keyword, supplierCode);
        } else {
            preInBillList = preInBillDao.select(keyword);
        }
        //???Page?????????total????????????
        total = preInBillList.size();
        page.setTotal(total);
        //????????????????????????????????????????????????
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(preInBillList.subList(startIndex, endIndex));
        //???Page??????PageInfo
        return new PageInfo<>(page);
    }


    /**
     * ??????????????????????????????
     *
     * @param keyword
     * @param pageSize
     * @param pageNum
     */
    @Override
    public List<ReagentPreInBillMess> getPrintData(String keyword, String printType, String billType, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        List<ReagentPreInBillMess> billList = null;
        switch (printType) {
            case "1":
                billList = preInBillDao.getPrintData(keyword);
                break;
            case "2":
                billList = orderDao.getPrintData(keyword);
                break;
            case "3":
                if (billType.equals("3")) {
                    billList = inBillDao.getBranchPrintData(keyword);
                } else {
                    billList = inBillDao.getPrintData(keyword);
                }
                break;
            case "4":
                billList = outBillDao.getPrintData(keyword);
                break;
            case "5":
                billList = collectDao.getPrintData(keyword);
                break;
            case "6":
                billList = refundDao.getPrintData(keyword);
                break;
        }

        return billList;
    }


    @Override
    public ReagentPreInBill getItem(Long id) {

        return preInBillMapper.selectByPrimaryKey(id);
    }

    /**
     * @param billStatus
     * @return
     */
    @Override
    public List<ReagentPreInBill> searchByBS(String billStatus, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        ReagentPreInBillExample example = new ReagentPreInBillExample();
        ReagentPreInBillExample.Criteria criteria = example.createCriteria();
        criteria.andBillStatusEqualTo(billStatus);
        return preInBillMapper.selectByExample(example);
    }

    /**
     * ????????????????????????????????????
     *
     * @param billCode
     */
    @Override
    public List<ReagentItem> searchCodeList(String billCode) {
        List<ReagentItem> codeList;
        codeList = preInDetailItemDao.searchCodeByBC(billCode);
        return codeList;
    }

}
