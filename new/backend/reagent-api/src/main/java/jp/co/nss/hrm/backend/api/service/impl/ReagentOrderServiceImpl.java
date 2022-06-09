package jp.co.nss.hrm.backend.api.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminDao;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminRoleRelationDao;
import jp.co.nss.hrm.backend.api.dao.ReagentOrderDao;
import jp.co.nss.hrm.backend.api.dto.ReagentOrderMess;
import jp.co.nss.hrm.backend.api.dto.ReagentOrderPost;
import jp.co.nss.hrm.backend.api.dto.ReagentPreOrder;
import jp.co.nss.hrm.backend.api.service.ReagentOrderService;
import jp.co.nss.hrm.backend.mapper.*;
import jp.co.nss.hrm.backend.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ReagentOrderServiceImpl implements ReagentOrderService {

    @Autowired
    private ReagentOrderMapper orderMapper;

    @Autowired
    private ReagentPreInBillMapper preInBillMapper;

    @Autowired
    private ReagentSupplierMapper supplierMapper;

    @Autowired
    private ReagentBaseInfoMapper baseInfoMapper;

    @Autowired
    private ReagentOrderDetailMapper orderDetailMapper;

    @Autowired
    private ReagentOrderDao orderDao;

    @Autowired
    private ReagentAdminDao adminDao;

    @Autowired
    private ReagentAdminRoleRelationDao adminRoleDao;

    /**
     * 获取所有订单列表
     */
    @Override
    public List<ReagentOrder> list() {

        return orderMapper.selectByExample(new ReagentOrderExample());
    }


    public String orderCount() {

        return orderDao.orderCount(null);
    }


    /**
     * 添加订单
     *
     * @param order
     * @return Map<供货商id, 订单号>
     */
    @Override
    public Map<String, String> create(ReagentOrderPost order) {
        String orderStates = order.getOrderState();
        List<ReagentOrderMess> orderMessList = order.getOrderMessList();
        List<String> baseInfos = new ArrayList<>();
        orderMessList.forEach(item -> baseInfos.add(item.getReagentCode()));

        // 获取数据库中订单中所有药品详情
        ReagentBaseInfoExample baseInfoExample = new ReagentBaseInfoExample();
        ReagentBaseInfoExample.Criteria criteria = baseInfoExample.createCriteria();
        criteria.andCodeIn(baseInfos);
        // 存储所有订单详细信息
        List<ReagentBaseInfo> baseInfoDetailList = baseInfoMapper.selectByExample(baseInfoExample);

        //按供应商ID分组
        Map<String, List<ReagentPreOrder>> orderSort = new HashMap<>();
        orderMessList.forEach(item -> {
            //判断新增加的药剂是否已经有对应的供应商订单
            if (orderSort.containsKey(item.getSupplierId())) {
                baseInfoDetailList.forEach(baseInfoItem -> {
                    if (baseInfoItem.getCode().equals(item.getReagentCode())) {
                        ReagentPreOrder reagentPreOrder = new ReagentPreOrder();
                        reagentPreOrder.setInfo(baseInfoItem);
                        reagentPreOrder.setInfoNumber(item.getNumber());
                        orderSort.get(item.getSupplierId()).add(reagentPreOrder);
                    }
                });
            } else {//如果没有，创建一条新的订单信息,里面包含订单详细和数量
                baseInfoDetailList.forEach(baseInfoItem -> {
                    if (baseInfoItem.getCode().equals(item.getReagentCode())) {
                        ReagentPreOrder reagentPreOrder = new ReagentPreOrder();
                        reagentPreOrder.setInfo(baseInfoItem);
                        reagentPreOrder.setInfoNumber(item.getNumber());
                        List<ReagentPreOrder> list = new ArrayList<>();
                        list.add(reagentPreOrder);
                        orderSort.put(item.getSupplierId(), list);
                    }
                });
            }
        });

        Date date = new Date();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());                    //放入Date类型数据

        int OrderDay_Year = calendar.get(Calendar.YEAR);                    //获取年份
        int OrderDay_MONTH = calendar.get(Calendar.MONTH) + 1;             //获取月份
        int OrderDay_DATE = calendar.get(Calendar.DAY_OF_MONTH);            //获取日
        String orderDay = OrderDay_Year + "-" + OrderDay_MONTH + "-" + OrderDay_DATE;

        Map<String, String> mapOrderNoSortBySupplierCode = new HashMap<>();

        try {
            orderSort.forEach((item, messList) -> {
                double totalPrice = messList.stream().mapToDouble(priceItem -> priceItem.getInfoNumber().longValue() * priceItem.getInfo().getPrice()).sum();

                // 订单信息
                ReagentOrder orderItem = new ReagentOrder();
                orderItem.setSupplierId(Long.parseLong(item));
                orderItem.setSupplierShortName(messList.get(0).getInfo().getSupplierShortName());
                orderItem.setOrderStatus(orderStates);
                orderItem.setCreateTime(date);
                orderItem.setOrderDay(orderDay);
                orderItem.setOrderPrice(totalPrice);
                orderItem.setOrderDescribe(order.getOrderDescribe());
                orderItem.setCreateBy(order.getCreateBy());

                Long time1 = new Date().getTime();
                Random ne2 = new Random();//实例化一个random的对象ne
                int x2 = ne2.nextInt(999 - 100 + 1) + 100;//为变量赋随机值100-999
                String random_order2 = String.valueOf(x2);
                String orderNo = time1 + random_order2;

                orderItem.setOrderNo(orderNo);

                mapOrderNoSortBySupplierCode.put(messList.get(0).getInfo().getSupplierId(), orderNo);

                int result = orderMapper.insert(orderItem);

                if (result > 0) {
                    messList.forEach(orderInfo -> {
                        ReagentOrderDetail orderDetail = new ReagentOrderDetail();
                        orderDetail.setOrderNo(orderNo);
                        orderDetail.setCreateTime(date);
                        orderDetail.setReagentCode(orderInfo.getInfo().getCode());
                        orderDetail.setReagentName(orderInfo.getInfo().getName());
                        orderDetail.setReagentNumber(orderInfo.getInfoNumber().longValue());
                        orderDetail.setUnit(orderInfo.getInfo().getUnit());
                        orderDetail.setSpecification(orderInfo.getInfo().getSpecification());
                        orderDetail.setManufacturerName(orderInfo.getInfo().getManufacturerName());
                        orderDetail.setPrice(orderInfo.getInfo().getPrice());
                        orderDetail.setSendNum(0L);
                        orderDetail.setUnsendNum(orderInfo.getInfoNumber().longValue());
                        orderDetailMapper.insert(orderDetail);
                    });
                }
            });

            return mapOrderNoSortBySupplierCode;

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 修改订单信息
     *
     * @param id
     * @param order
     */
    @Override
    public int update(Long id, ReagentOrder order) {
        order.setId(id);
        return orderMapper.updateByPrimaryKeySelective(order);
    }

    /**
     * 根据订单号修改订单状态
     *
     * @param orderNo
     * @param order
     */
    @Override
    public int updateByON(String orderNo, ReagentOrder order) {
        //更新订单汇总表状态
        String orderStatus = order.getOrderStatus();

        //更新订单汇总表总价格
        ReagentOrderDetailExample orderDetailExample = new ReagentOrderDetailExample();
        ReagentOrderDetailExample.Criteria criteria = orderDetailExample.createCriteria();
        criteria.andOrderNoEqualTo(orderNo);

        List<ReagentOrderDetail> orderDetail = orderDetailMapper.selectByExample(orderDetailExample);

        double totalPrice = 0;
        // 使用增强for循环,  之前用的是stream式循环 8后更新的 可能调用外部变量方式不同
        for (ReagentOrderDetail listItem : orderDetail) {
            totalPrice += listItem.getPrice() * listItem.getReagentNumber();
        }
        orderDao.updateOrderPrice(orderNo, totalPrice);

        return orderDao.updateByON(orderNo, orderStatus);
    }

    /**
     * 根据ID撤销订单
     *
     * @param id
     */
    @Override
    public int revokeOrder(Long id) {
        ReagentOrder order = orderMapper.selectByPrimaryKey(id);
        order.setOrderStatus("3");

        //更新随货单状态为撤销状态：0
        String orderNo = order.getOrderNo();
        ReagentPreInBillExample preInBillExample = new ReagentPreInBillExample();
        preInBillExample.createCriteria().andBillCodeEqualTo(orderNo);
        List<ReagentPreInBill> preInBillList = preInBillMapper.selectByExample(preInBillExample);
        //若是已经生成随货单
        if (!preInBillList.isEmpty()) {
            Long preId = preInBillList.get(0).getId();

            ReagentPreInBill preInBill = preInBillMapper.selectByPrimaryKey(preId);
            preInBill.setBillStatus("0");
            preInBillMapper.updateByPrimaryKeySelective(preInBill);
        }

        return orderMapper.updateByPrimaryKeySelective(order);
    }

    /**
     * 根据ID关闭订单
     *
     * @param id
     */
    @Override
    public int closeOrder(Long id) {
        ReagentOrder order = orderMapper.selectByPrimaryKey(id);
        order.setOrderStatus("4");

        //更新随货单状态为已关闭状态：5
        String orderNo = order.getOrderNo();
        ReagentPreInBillExample preInBillExample = new ReagentPreInBillExample();
        preInBillExample.createCriteria().andBillCodeEqualTo(orderNo);
        List<ReagentPreInBill> preInBillList = preInBillMapper.selectByExample(preInBillExample);
        //若是已经生成随货单
        if (!preInBillList.isEmpty()) {
            Long preId = preInBillList.get(0).getId();

            ReagentPreInBill preInBill = preInBillMapper.selectByPrimaryKey(preId);
            preInBill.setBillStatus("5");
            preInBillMapper.updateByPrimaryKeySelective(preInBill);
        }
        return orderMapper.updateByPrimaryKeySelective(order);
    }

    /**
     * 批量删除订单
     *
     * @param ids
     */

    @Override
    public int delete(List<Long> ids) {
        ReagentOrderExample example = new ReagentOrderExample();
        example.createCriteria().andIdIn(ids);
        return orderMapper.deleteByExample(example);
    }

    /**
     * 分页获取订单列表
     *
     * @param keyword
     * @param pageSize
     * @param pageNum
     */
    @Override
    public PageInfo<ReagentOrder> list(String keyword, String username, Integer pageSize, Integer pageNum) {
        //先拿username查admin表的admin_id
        //再用admin_id查admin_role表的role_id
        //根据role_id判断是供应商5或者中心库管员2/6
        //if供货商，用username查order表的供货商名，输出该供货商所有数据
        //else中心库管输出所有数据

        //创建Page类
        Page<ReagentOrder> page = new Page<>(pageNum, pageSize);
        int total;

        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        String supplier = adminDao.selectSupplier(username);
        List<ReagentOrder> orderList;

        if (roleId == 5) {
            ReagentSupplierExample supplierExample = new ReagentSupplierExample();
            supplierExample.createCriteria().andSupplierShortNameEqualTo(supplier);
            List<ReagentSupplier> supplierList = supplierMapper.selectByExample(supplierExample);
            String supplierCode = supplierList.get(0).getSupplierCode();
            orderList = orderDao.selectBySupplier(keyword, supplierCode);
        } else {
            orderList = orderDao.select(keyword);
        }
        //为Page类中的total属性赋值
        total = orderList.size();
        page.setTotal(total);
        //计算当前需要显示的数据下标起始值
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(orderList.subList(startIndex, endIndex));
        //以Page创建PageInfo
        return new PageInfo<>(page);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public ReagentOrder getItem(Long id) {
        return orderMapper.selectByPrimaryKey(id);
    }

    public int deleteByOrderNo(String orderNo) {
        ReagentOrderExample example = new ReagentOrderExample();
        example.createCriteria().andOrderNoEqualTo(orderNo);
        int count = orderMapper.deleteByExample(example);
        return count;
    }

    public int getRoleId(String username) {
        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        return roleId.intValue();
    }

    public String getphonenum(String num) {
        return orderMapper.getphonenum(num);
    }
}