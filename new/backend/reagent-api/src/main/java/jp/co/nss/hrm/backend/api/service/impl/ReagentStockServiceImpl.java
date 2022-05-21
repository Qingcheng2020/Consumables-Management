package jp.co.nss.hrm.backend.api.service.impl;

import java.util.*;

import cn.hutool.core.date.DateUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.*;
import jp.co.nss.hrm.backend.api.dto.ReagentInBillDetail;
import jp.co.nss.hrm.backend.api.dto.ReagentInBillVm;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.api.dto.ReagentOutDetailItem;
import jp.co.nss.hrm.backend.api.enums.BillStatus;
import jp.co.nss.hrm.backend.api.service.ReagentStockService;
import jp.co.nss.hrm.backend.mapper.ReagentOutBillMapper;
import jp.co.nss.hrm.backend.mapper.ReagentOutDetailItemMapper;
import jp.co.nss.hrm.backend.mapper.ReagentStockMapper;
import jp.co.nss.hrm.backend.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class ReagentStockServiceImpl implements ReagentStockService {
    @Autowired
    private ReagentStockMapper stockMapper;
    @Autowired
    private ReagentStockDao stockDao;
    @Autowired
    private ReagentAdminDao adminDao;
    @Autowired
    private ReagentAdminRoleRelationDao adminRoleDao;
    @Autowired
    private ReagentCollectDetailDao collectDetailDao;
    @Autowired
    private ReagentOutBillMapper outBillMapper;
    @Autowired
    private ReagentOutDetailDao outDetailDao;
    @Autowired
    private ReagentOutItemDao outItemDao;
    @Autowired
    private ReagentInBillDao inBillDao;
    @Autowired
    private ReagentInDetailDao inDetailDao;
    @Autowired
    private ReagentInDetailItemDao inDetailItemDao;

    public String stockCount() {

        return stockDao.stockCount();
    }

    /**
     * 获取所有库存列表
     */
    @Override
    public List<ReagentStock> list() {

        return stockMapper.selectByExample(new ReagentStockExample());
    }

    /**
     * 添加中心库库存
     *
     * @param stock
     */
    @Override
    public int create(ReagentStock stock) {

        stock.setCreateTime(new Date());
        return stockMapper.insert(stock);
    }

    /**
     * 修改库存信息
     *
     * @param id
     * @param stock
     */
    @Override
    public int update(Long id, ReagentStock stock) {
        stock.setId(id);
        return stockMapper.updateByPrimaryKeySelective(stock);
    }

    /**
     * 删除指定库存
     */
    @Override
    public int delete(Long id) {
        return stockMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页获取库存列表
     *
     * @param stockType
     * @param pageSize
     * @param pageNum
     */
    @Override
    public List<ReagentStock> list(String stockType, String username, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);

        //先拿username查admin表的admin_id和branch
        //再用admin_id查admin_role表的role_id
        //根据role_id判断是科室库管3或者中心库管员2/6
        //if科室库管，用branch查stock表的科室名，输出该stockType=1且branch=科室名称的所有数据
        //if中心库管输出stockType且科室名称为空的所有数据

        return null;
    }

    @Override
    public List<ReagentInfo> getItemBySN(String username, String stockNo) {
        List<ReagentStock> stockListAll;
        List<ReagentInfo> stockInfoList = new ArrayList<>();
        ReagentInfo stockInfo = new ReagentInfo();

        String branch = adminDao.selectBranch(username);
        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);

        ReagentStockExample stockExample = new ReagentStockExample();
        stockExample.createCriteria().andStockNoEqualTo(stockNo);
        stockListAll = stockMapper.selectByExample(stockExample);

        //获取库存详细表中到期日期和系统批号
        ReagentInfo reagentInfo = stockDao.getDetailData(stockNo);

        if (stockListAll.size() > 0) {
            for (ReagentStock item : stockListAll) {
                String quantity;
                // 试剂操作员的试剂在库数量为 科室库和已出库的试剂总数
                if (roleId == 4 || roleId == 9) {
                    quantity = stockDao.getDetailNumByOperator(item.getStockNo(), branch);
                } else {
                    quantity = stockDao.getDetailNum(item.getStockNo(), branch);
                }

                if (!quantity.equals("0")) {
                    stockInfo.setReagentId(Long.valueOf(item.getReagentId()));
                    stockInfo.setReagentName(item.getReagentName());
                    stockInfo.setSpecification(item.getReagentType());
                    stockInfo.setManufacturerName(item.getFactory());
                    stockInfo.setRegistrationNo(reagentInfo.getRegistrationNo());
                    stockInfo.setSupplierShortName(item.getSupplierName());
                    stockInfo.setUnit(item.getReagentUnit());
                    stockInfo.setStockType(item.getReagentTemp());
                    stockInfo.setStatus(item.getReagentStatus());
                    stockInfoList.add(stockInfo);
                }
            }
        }
        return stockInfoList;
    }

    /**
     * 分页获取库存列表
     * 根据库存单号获取一级库还是二级库模式
     * 根据username获取branch，中心库branch为空，科室库branch为对应科室名
     * 前台页面库存数量通过计算获得
     */
    @Override
    public PageInfo<ReagentStock> search(String stockType, String reagentName, String supplierName,
                                         String factory, String reagentTemp, String username,
                                         Integer pageSize, Integer pageNum) {
        String branch = adminDao.selectBranch(username);
        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);

        //admin返回全部
        PageInfo<ReagentStock> stockListAll = PageHelper.startPage(pageNum, pageSize).doSelectPageInfo(() -> {
            stockDao.selectByBranch(stockType, reagentName, supplierName, factory, reagentTemp, branch);
        });
        //筛选之前的全部
        List<ReagentStock> stockListAll1 = stockDao.selectByBranch(stockType, reagentName, supplierName, factory, reagentTemp, branch);

        //最终结果
        List<ReagentStock> stockList = new ArrayList<>();
        //创建Page类
        Page<ReagentStock> page = new Page<>(pageNum, pageSize);
        int total;

        if (stockListAll1.size() > 0) {
            for (ReagentStock item : stockListAll1) {
                String remainDay = stockDao.getDetailRemainDay(item.getStockNo(), branch);
                if (remainDay == null) remainDay = "0";
                item.setOverdueStock(Integer.parseInt(remainDay));
                item.setBranchName(branch);
                String quantity;
                // 试剂操作员的试剂在库数量为 科室库和已出库的试剂总数
                if (roleId == 4 || roleId == 9) {
                    quantity = stockDao.getDetailNumByOperator(item.getStockNo(), branch);
                } else {
                    quantity = stockDao.getDetailNum(item.getStockNo(), branch);
                }
                ReagentInfo rs = stockDao.getDetailData(item.getStockNo());
                if (!quantity.equals("0")) {
                    //  item.setOverdueStock(daysDiff);
                    item.setQuantity(Long.valueOf(quantity));
                    item.setExpireDate(rs.getExpireDate().toString());
                    item.setBatchNo(rs.getBatchNo());
                    stockList.add(item);
                }
            }
            //为Page类中的total属性赋值
            total = stockList.size();
            page.setTotal(total);
            //计算当前需要显示的数据下标起始值
            int startIndex = (pageNum - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, total);
            page.addAll(stockList.subList(startIndex, endIndex));
            //以Page创建PageInfo
            return new PageInfo<>(page);
        } else {
            return stockListAll;
        }
    }

    @Override
    public PageInfo<ReagentStock> searchLow(Integer type, String reagentName, String supplierName,
                                            String factory, String reagentTemp, String username,
                                            Integer pageSize, Integer pageNum) {

        List<ReagentStock> stockList = new ArrayList<>();
        List<ReagentStock> lowOrOverList = new ArrayList<>();

        //创建Page类
        Page<ReagentStock> page = new Page<>(pageNum, pageSize);
        int total;

        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        //中心库的branch是中心库
        String branch = adminDao.selectBranch(username);
        String stockType = null;
        if (roleId == 1) {
            stockType = null;
        } else if (roleId == 2 || roleId == 4 || roleId == 7) {
            stockType = "1";
        } else if (roleId == 3 || roleId == 6 || roleId == 8 || roleId == 9) {
            stockType = "3";
        }
        List<ReagentStock> stockListAll = stockDao.selectByBranch(stockType, reagentName, supplierName, factory, reagentTemp, branch);

        for (ReagentStock item : stockListAll) {
            String remainDay = stockDao.getDetailRemainDay(item.getStockNo(), branch);
            if (remainDay == null) remainDay = "0";
            item.setOverdueStock(Integer.parseInt(remainDay));
            item.setBranchName(branch);
            String quantity;
            if (roleId == 4 || roleId == 9) {
                // 试剂操作员的试剂在库数量为 科室库和已出库的试剂总数
                quantity = stockDao.getDetailNumByOperator(item.getStockNo(), branch);
            } else {
                quantity = stockDao.getDetailNum(item.getStockNo(), branch);
            }
            ReagentInfo rs = stockDao.getDetailData(item.getStockNo());
            if (!quantity.equals("0")) {
                item.setQuantity(Long.valueOf(quantity));
                item.setExpireDate(rs.getExpireDate().toString());
                item.setBatchNo(rs.getBatchNo());
                stockList.add(item);
            }
        }
        //低库存
        if (type == 1) {
            for (ReagentStock stockItem : stockList) {
                if (stockItem.getQuantity() <= Long.parseLong(stockItem.getLowStock())) {
                    lowOrOverList.add(stockItem);
                }
            }
        }
        //过期
        else if (type == 2) {
            for (ReagentStock stockItem : stockList) {
                if (stockItem.getOverdueStock() <= stockItem.getOverdue()) {
                    lowOrOverList.add(stockItem);
                }
            }
        }

        //为Page类中的total属性赋值
        total = lowOrOverList.size();
        page.setTotal(total);
        //计算当前需要显示的数据下标起始值
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(lowOrOverList.subList(startIndex, endIndex));
        //以Page创建PageInfo
        return new PageInfo<>(page);
    }

    /**
     * 分页获取移库库存列表
     * 根据库存单号获取一级库还是二级库模式
     * 根据applyType判断申请类型，1为二级领用、3为一级领用、2为移库
     * 根据username获取branch，移库则设置branch为空，查找中心库；一级领用查中心，二级领用根据branch查科室库
     * 前台页面库存数量通过计算获得
     */
    @Override
    public PageInfo<ReagentStock> relocationList(String stockType, String username, String applyType, String keyword, Integer pageSize, Integer pageNum) {
        List<ReagentStock> stockListAll;
        List<ReagentStock> stockList = new ArrayList<>();

        //创建Page类
        Page<ReagentStock> page = new Page<>(pageNum, pageSize);
        int total;

        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);

        String branch = null;
        if (applyType.equals("2")) branch = "中心库";
        if (applyType.equals("1") || applyType.equals("3")) branch = adminDao.selectBranch(username);

        stockListAll = stockDao.relocationList(stockType, branch, keyword);
        for (ReagentStock item : stockListAll) {
            String quantity;
            String stockQuantity;
            String collQuantity;
            if (roleId == 4 || roleId == 9) {
                // 试剂操作员的试剂在库数量为 科室库和已出库的试剂总数
                quantity = stockDao.getDetailNumByOperator(item.getStockNo(), branch);
            } else {
                stockQuantity = stockDao.getDetailNum(item.getStockNo(), branch);
                collQuantity = collectDetailDao.getDetailNum(item.getReagentId());
                if (stockQuantity == null) stockQuantity = "0";
                if (collQuantity == null) collQuantity = "0";

                quantity = String.valueOf(Integer.parseInt(stockQuantity) - Integer.parseInt(collQuantity));
            }
            if (!quantity.equals("0")) {
                item.setQuantity(Long.valueOf(quantity));
                stockList.add(item);
            }
        }
        //为Page类中的total属性赋值
        total = stockList.size();
        page.setTotal(total);
        //计算当前需要显示的数据下标起始值
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(stockList.subList(startIndex, endIndex));
        //以Page创建PageInfo
        return new PageInfo<>(page);
    }

    /**
     * 在库查询
     */
    @Override
    public List<ReagentInfo> searchStock(String batchNo, String qrCode) {

        return stockDao.getStockList(batchNo, qrCode);
    }

    /**
     * 在库查询
     */
    @Override
    public ReagentStock findReagentItem(String qrCode) {

        return stockDao.findReagentItem(qrCode);
    }

    public int outFromBranch(ReagentStock stock){
        long Number=stock.getoutNumber();
        String name=stock.getBranchName();

        //fisrt
        ReagentOutBill outBill = new ReagentOutBill();
        Date timeNow = new Date();

        Long time1 = new Date().getTime();
        Random ne2 = new Random();//实例化一个random的对象ne
        int x2 = ne2.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
        String random_order2 = String.valueOf(x2);
        String billCode = time1 + random_order2;

        String creater =stockMapper.findhead(name);

        outBill.setBillCode(billCode);
        outBill.setBillType("2");
        outBill.setBillDate(timeNow);
        outBill.setBillStatus(true);
        outBill.setBillCreator(creater);
        outBill.setBranchName(name);
        outBill.setUpdateTime(timeNow);
        outBill.setCreateTime(timeNow);
        outBill.setApplicationDate(timeNow);
        outBill.setApplicationUser(stock.getapplier());
        outBillMapper.insert(outBill);

        //second
        ReagentOutDetail outDetail = new ReagentOutDetail();
        List<ReagentOutDetail> outDetailList = new ArrayList<>();
        //生成出库单详情号
        Long time2 = new Date().getTime();
        Random ne3 = new Random();//实例化一个random的对象ne
        int x3 = ne3.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
        String random_order3 = String.valueOf(x3);
        String outDetailId = time2 + random_order3;

        String registration=stockMapper.getregistration(stock.getReagentId());

        outDetail.setId(outBill.getId());
        outDetail.setReagentName(stock.getReagentName());
        outDetail.setBillCode(billCode);
        outDetail.setOutDetailId(outDetailId);
        outDetail.setReagentId(stock.getReagentId());
        outDetail.setReagentSpecification(stock.getReagentType());
        outDetail.setFactory(stock.getFactory());
        outDetail.setRegistrationNo(registration);
        outDetail.setSupplierShortName(stock.getSupplierName());
        outDetail.setReagentUnit(stock.getReagentUnit());
        outDetail.setPrice(stock.getReagentPrice());
        outDetail.setQuantity(Number);
        Double total= Number*stock.getReagentPrice();
        outDetail.setTotal(total);
        outDetail.setCreateTime(timeNow);
        outDetail.setCreateBy(creater);
        outDetail.setApplicationUser(stock.getapplier());
        outDetail.setUpdateTime(timeNow);
        outDetail.setUpdateBy(creater);
        outDetailList.add(outDetail);

        outDetailDao.insertOutDetail(outDetailList);

        //third
        List<Map<String,String>> stockDetails=stockMapper.findfrombranch(stock.getStockNo(),Number,name);
        List<ReagentOutDetailItem> reagentOutDetailItemsList = new ArrayList<>();
        for(int i=0;i<stockDetails.size();i++){
            ReagentOutDetailItem item = new ReagentOutDetailItem();
            item.setBillCode(billCode);
            item.setOutDetailId(outDetailId);
            item.setCreateTime(timeNow);
            item.setCreateBy(creater);
            item.setUpdateBy(creater);
            item.setUpdateTime(timeNow);
            item.setReagentCode(stockDetails.get(i).get("reagent_code"));
            item.setQrCode(stockDetails.get(i).get("qr_code"));
            item.setCodeValue(stockDetails.get(i).get("code_value"));

            reagentOutDetailItemsList.add(item);
        }
        outItemDao.insertItem(reagentOutDetailItemsList);



        return stockMapper.outFromBranch(stock.getStockNo(),Number,name);

    }

    public int outFromCentre(Long id,String destination){
        //中心库出库汇总
        //first
        ReagentOutBill outBill = new ReagentOutBill();
        Date timeNow = new Date();
        String creater =stockMapper.findhead("中心库");
        String recevier =stockMapper.findhead(destination);


        Long time1 = new Date().getTime();
        Random ne1 = new Random();//实例化一个random的对象ne
        int x1 = ne1.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
        String random_order1 = String.valueOf(x1);
        String billCode = time1 + random_order1;

        outBill.setBillCode(billCode);
        outBill.setBillType("3");
        outBill.setBillDate(timeNow);
        outBill.setBillStatus(true);
        outBill.setBillCreator(creater);
        outBill.setBranchName("中心库");
        outBill.setUpdateTime(timeNow);
        outBill.setCreateTime(timeNow);
        outBill.setApplicationDate(timeNow);
        outBill.setApplicationUser(recevier);
        outBillMapper.insert(outBill);



        //second
        List<ReagentOutDetailItem> reagentOutDetailItemsList = new ArrayList<>();
        List<Map<String,Long>> reagentCollectDetails=stockMapper.getdata(id);
        List<List<Map<String,Object>>> findcenter =new ArrayList<>();
        for (int i=0;i<reagentCollectDetails.size();i++){
            findcenter.add(stockMapper.findFromCentre(destination, String.valueOf(reagentCollectDetails.get(i).get("reagent_code")),reagentCollectDetails.get(i).get("reagent_number")));}


        List<ReagentOutDetail> outDetailList = new ArrayList<>();

        for(int i=0;i<findcenter.size();i++) {
            //生成出库单详情号
            Long time2 = new Date().getTime();
            Random ne2 = new Random();//实例化一个random的对象ne
            int x2 = ne2.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
            String random_order2 = String.valueOf(x2);
            String outDetailId = time2 + random_order2;


            ReagentOutDetail outDetail = new ReagentOutDetail();

            outDetail.setId(outBill.getId());
            outDetail.setReagentName((String) findcenter.get(i).get(0).get("reagent_name"));
            outDetail.setBillCode(billCode);
            outDetail.setOutDetailId(outDetailId);
            outDetail.setReagentId((String) findcenter.get(i).get(0).get("reagent_id"));
            outDetail.setReagentSpecification((String) findcenter.get(i).get(0).get("specification"));
            outDetail.setFactory((String) findcenter.get(i).get(0).get("manufacturer_name"));
            outDetail.setRegistrationNo((String) findcenter.get(i).get(0).get("registration_no"));
            outDetail.setSupplierShortName((String) findcenter.get(i).get(0).get("supplier_short_name"));
            outDetail.setReagentUnit((String) findcenter.get(i).get(0).get("reagent_unit"));
            outDetail.setPrice((Double) findcenter.get(i).get(0).get("reagent_price"));
            outDetail.setQuantity(reagentCollectDetails.get(i).get("reagent_number"));
            Double total = (Double) findcenter.get(i).get(0).get("reagent_price")*reagentCollectDetails.get(i).get("reagent_number");
            outDetail.setTotal(total);
            outDetail.setCreateTime(timeNow);
            outDetail.setCreateBy(creater);
            outDetail.setApplicationUser(recevier);
            outDetail.setUpdateTime(timeNow);
            outDetail.setUpdateBy(creater);

            outDetailList.add(outDetail);


            //third
            for(int j=0;j<findcenter.get(i).size();j++){
                ReagentOutDetailItem item = new ReagentOutDetailItem();
                item.setBillCode(billCode);
                item.setOutDetailId(outDetailId);
                item.setCreateTime(timeNow);
                item.setCreateBy(creater);
                item.setUpdateBy(creater);
                item.setUpdateTime(timeNow);
                item.setReagentCode((String) findcenter.get(i).get(j).get("reagent_code"));
                item.setQrCode((String) findcenter.get(i).get(j).get("qr_code"));
                item.setCodeValue((String) findcenter.get(i).get(j).get("code_value"));

                reagentOutDetailItemsList.add(item);
            }
        }
        outItemDao.insertItem(reagentOutDetailItemsList);
        outDetailDao.insertOutDetail(outDetailList);




        //科室库入库汇总
        //first
        ReagentInBillVm inBillAll = new ReagentInBillVm();

        Long time3 = new Date().getTime();
        Random ne3 = new Random();//实例化一个random的对象ne
        int x3 = ne3.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
        String random_order3 = String.valueOf(x3);
        String inBillCode = time3 + random_order3;

        inBillAll.setBillCode(inBillCode);
        inBillAll.setPreInBillCode(String.valueOf(id));
        inBillAll.setBillType("3");
        inBillAll.setCreateType("4");
        inBillAll.setCreateBy(creater);
        inBillAll.setBillDate(timeNow);
        inBillAll.setBillStatus("1");
        inBillAll.setBranch(destination);
        inBillAll.setBillCreator(creater);
        inBillAll.setUpdateTime(timeNow);
        inBillAll.setCreateTime(timeNow);

        inBillDao.insert(inBillAll);



        //second
        List<ReagentInBillDetail> reagentInDetailList = new ArrayList<>();
        List<ReagentInDetailItem> reagentInDetailItemList = new ArrayList<>();
        for(int i=0;i<findcenter.size();i++) {

            Long time4 = new Date().getTime();
            Random ne4 = new Random();//实例化一个random的对象ne
            int x4 = ne4.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
            String random_order4 = String.valueOf(x4);
            String inDetailId = time4 + random_order4;

            ReagentInBillDetail inDetail = new ReagentInBillDetail();

            inDetail.setBillCode(inBillCode);
            inDetail.setInDetailId(inDetailId);
            inDetail.setReagentId((String) findcenter.get(i).get(0).get("reagent_id"));
            inDetail.setReagentName((String) findcenter.get(i).get(0).get("reagent_name"));
            inDetail.setReagentUnit((String) findcenter.get(i).get(0).get("reagent_unit"));
            inDetail.setReagentSpecification((String) findcenter.get(i).get(0).get("specification"));
            inDetail.setFactory((String) findcenter.get(i).get(0).get("manufacturer_name"));
            inDetail.setPrice((Double) findcenter.get(i).get(0).get("reagent_price"));
            inDetail.setQuantity(reagentCollectDetails.get(i).get("reagent_number"));
            Double total = inDetail.getQuantity()*inDetail.getPrice();
            inDetail.setTotal(total);
            inDetail.setCreateBy(creater);
            inDetail.setCreateTime(timeNow);

            reagentInDetailList.add(inDetail);

            for(int j=0;j<findcenter.get(i).size();j++){
                ReagentInDetailItem item = new ReagentInDetailItem();
                item.setBillCode(inBillCode);
                item.setInDetailId(inDetailId);
                item.setStatus("1");
                item.setQrCode((String) findcenter.get(i).get(j).get("qr_code"));
                item.setCodeValue((String) findcenter.get(i).get(j).get("code_value"));
                item.setReagentCode((String) findcenter.get(i).get(j).get("reagent_code"));
                item.setCreateTime(timeNow);
                item.setCreateBy(creater);
                reagentInDetailItemList.add(item);


            }


        }





        inDetailDao.insertInDetail(reagentInDetailList);
        inDetailItemDao.insertBillItem(reagentInDetailItemList);


            for (int i = 0; i < reagentCollectDetails.size(); i++) {
                stockMapper.outFromCentre(destination, String.valueOf(reagentCollectDetails.get(i).get("reagent_code")), reagentCollectDetails.get(i).get("reagent_number"));
            }

            return 1;

    }
}

