package jp.co.nss.hrm.backend.api.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminDao;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminRoleRelationDao;
import jp.co.nss.hrm.backend.api.dao.ReagentCollectDetailDao;
import jp.co.nss.hrm.backend.api.dao.ReagentStockDao;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.api.service.ReagentStockService;
import jp.co.nss.hrm.backend.mapper.ReagentStockMapper;
import jp.co.nss.hrm.backend.model.ReagentStock;
import jp.co.nss.hrm.backend.model.ReagentStockCentre;
import jp.co.nss.hrm.backend.model.ReagentStockExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
        long Quantity=stock.getQuantity();
        long Number=stock.getoutNumber();
        stock.setQuantity(Quantity-Number);
        stockMapper.updateByPrimaryKeySelective(stock);
        return stockMapper.outFromBranch(stock.getStockNo(),Number);

    };
}

