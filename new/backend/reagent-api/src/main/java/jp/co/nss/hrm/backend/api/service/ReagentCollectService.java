package jp.co.nss.hrm.backend.api.service;

import jp.co.nss.hrm.backend.api.dto.ReagentCollectPDAReq;
import jp.co.nss.hrm.backend.api.dto.ReagentCollectPost;
import jp.co.nss.hrm.backend.api.dto.ReagentInBillPDAReq;
import jp.co.nss.hrm.backend.api.dto.ReagentStatus;
import jp.co.nss.hrm.backend.model.ReagentCollect;
import java.util.List;

public interface ReagentCollectService {

    /**
     * 组别报表
     */

    List<ReagentStatus> countCollect(String username, String startTime, String endTime, Integer pageSize, Integer pageNum);


    ReagentCollect getItem(Long id);

    /**
     * 获取所有领用信息列表
     */

    List<ReagentCollect> list();

    /**
     * 添加领用
     */
    int create(ReagentCollectPost collect);

    /**
     * pda添加移库
     */
    int relocation(ReagentCollectPost collect);

    /**
     * 根据申请单类型查询申请单
     */
    List<ReagentCollect> getAllByApplyType(String applyType);

    /**
     * 修改领用信息
     */
    int update(Long id, ReagentCollect collect);

    /**
     * 根据入库单号修改入库单状态
     */
    int updateByCN(String collectNo, ReagentCollect collect) ;

    /**
     * 删除指定领用
     */
    int delete(List<Long> ids);

    /**
     * 分页获取领用列表
     */
    List<ReagentCollect> list(String applyType,String keyword, String username,Integer pageSize, Integer pageNum);

    /**
     * 根据申请编号删除
     */
    int deleteByCollectNo(String collectNo);

    /**
     * 一键移库
     */
    Integer createCollectPdaByOneKey(ReagentCollectPDAReq req, String username);

    int changeStatus(Long id);
}


