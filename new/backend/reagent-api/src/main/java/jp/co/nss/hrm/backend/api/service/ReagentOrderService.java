package jp.co.nss.hrm.backend.api.service;

import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dto.ReagentOrderPost;
import jp.co.nss.hrm.backend.model.ReagentOrder;

import java.util.List;
import java.util.Map;

public interface ReagentOrderService {

    ReagentOrder getItem(Long id);

    /**
     * 获取所有订单信息列表
     */
    List<ReagentOrder> list();

    /**
     * 添加订单
     */
    Map<String, String> create(ReagentOrderPost order);

    /**
     * 修改订单信息
     */
    int update(Long id, ReagentOrder order);

    /**
     * 根据订单号修改订单状态
     */
    int updateByON(String orderNo, ReagentOrder order);

    /**
     * 根据ID撤销订单
     */
    int revokeOrder(Long id);

    /**
     * 根据ID关闭订单
     */
    int closeOrder(Long id);


    /**
     * 删除指定订单
     */
    int delete(List<Long> ids);

    /**
     * 分页获取订单列表
     */
    PageInfo<ReagentOrder> list(String keyword, String username, Integer pageSize, Integer pageNum);

    int deleteByOrderNo(String orderNo);

    String orderCount();

    /**
     * 获取角色id
     */
    int getRoleId(String username);

    String getphonenum(String s);
}


