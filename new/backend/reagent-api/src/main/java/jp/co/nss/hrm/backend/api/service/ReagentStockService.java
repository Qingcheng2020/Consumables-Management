package jp.co.nss.hrm.backend.api.service;

import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.model.ReagentStock;
import jp.co.nss.hrm.backend.model.ReagentStockCentre;

import java.util.List;

public interface ReagentStockService {

    /**
     * 在库查询
     */
    List<ReagentInfo> searchStock(String batchNo, String qrCode);

    /**
     * 试剂查询
     */
    ReagentStock findReagentItem(String qrCode);

    /**
     * 根据库存编号查找
     */
    List<ReagentInfo> getItemBySN(String username, String keyword);

    /**
     * 获取所有库存信息列表
     */
    List<ReagentStock> list();

    /**
     * 添加库存信息
     */
    int create(ReagentStock stock);

    /**
     * 修改库存信息
     */
    int update(Long id, ReagentStock stock);

    /**
     * 删除指定库存
     */
    int delete(Long id);


    /**
     * 分页获取库存列表
     */
    List<ReagentStock> list(String stockType, String username, Integer pageSize, Integer pageNum);

    /**
     * 分页获取库存列表
     */
    PageInfo<ReagentStock> search(String stockType, String reagentName, String supplierName,
                                  String factory, String reagentTemp, String username,
                                  Integer pageSize, Integer pageNum);

    PageInfo<ReagentStock> searchLow(Integer type, String reagentName, String supplierName, String factory,
                                     String reagentTemp, String username, Integer pageSize, Integer pageNum);

    /**
     * 分页获取移库库存列表
     */
    PageInfo<ReagentStock> relocationList(String stockType, String username, String applyType, String keyword, Integer pageSize, Integer pageNum);

    String stockCount();

    int outFromBranch(ReagentStock stock);
}