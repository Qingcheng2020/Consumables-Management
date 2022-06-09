package jp.co.nss.hrm.backend.api.controller;

import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import jp.co.nss.hrm.backend.api.aop.annotation.OperationLogAnnotation;
import jp.co.nss.hrm.backend.api.dto.ReagentOrderMess;
import jp.co.nss.hrm.backend.api.dto.ReagentOrderPost;
import jp.co.nss.hrm.backend.api.dto.WxUser;
import jp.co.nss.hrm.backend.api.service.ReagentOrderService;
import jp.co.nss.hrm.backend.api.service.ReagentSupplierService;
import jp.co.nss.hrm.backend.api.service.WxService;
import jp.co.nss.hrm.backend.common.api.CommonResult;
import jp.co.nss.hrm.backend.common.util.SmsTentcent.Notify2Supplier;
import jp.co.nss.hrm.backend.common.util.WxSubscription.SubscriptionMessage;
import jp.co.nss.hrm.backend.model.ReagentOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import jp.co.nss.hrm.backend.common.util.SmsTentcent.*;

/**
 * 订单信息管理Controller
 * Created by macro on 2021/3/3.
 */
@Controller
@Api(tags = "ReagentOrderController", description = "订单信息管理")
@RequestMapping("/order")
public class ReagentOrderController {
    @Autowired
    private ReagentOrderService orderService;

    @Autowired
    private ReagentSupplierService supplierService;

    @Autowired
    private WxService wxService;

    @Value("${wx.mp.appid}")
    private String APPID;

    @Value("${wx.mp.appSecret}")
    private String APP_SECRET;

    @Value("${base-info.hospital-name}")
    private String HOSPITAL_NAME;

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "新增")
    @ApiOperation("添加订单信息")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult create(@RequestBody ReagentOrderPost order) {

        Map<String, String> mapOrderNoSortBySupplierCode = orderService.create(order);

        List<ReagentOrderMess> orderSet = order.getOrderMessList();


        // start: 通知供货商
        List<String> suppliersCode = new ArrayList<>();
        if (orderSet != null) {
            orderSet.forEach(item -> {
                // 此处请求参数中的的 supplierId 实际是 supplierCode
                suppliersCode.add(item.getSupplierId());
            });


        }
        System.out.println(suppliersCode);
        String []num= new String[suppliersCode.size()];
        for(int i=0;i<suppliersCode.size();i++){
            num[i]=orderService.getphonenum(suppliersCode.get(i));
        }

        Notify2Supplier.sendByGroup(num,"妇幼保健医院");

        if (mapOrderNoSortBySupplierCode.size() > 0) {
            return CommonResult.success(mapOrderNoSortBySupplierCode.size());
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "修改订单")
    @ApiOperation("修改订单信息")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult update(@PathVariable Long id, @RequestBody ReagentOrder order) {
        int count = orderService.update(id, order);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "修改状态")
    @ApiOperation("根据订单号修改订单状态")
    @RequestMapping(value = "/updateByON/{orderNo}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateByBC(@PathVariable String orderNo, @RequestBody ReagentOrder order) {
        int count = orderService.updateByON(orderNo, order);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "删除")
    @ApiOperation("删除订单")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult delete(@RequestParam("ids") List<Long> ids) {
        int count = orderService.delete(ids);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "根据单号删除")
    @ApiOperation("删除订单")
    @RequestMapping(value = "/deleteByNo", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult deleteByOrderNo(@RequestParam("orderNo") String orderNo) {
        int count = orderService.deleteByOrderNo(orderNo);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("获取所有订单信息")
    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentOrder>> listAll() {
        List<ReagentOrder> orderList = orderService.list();
        return CommonResult.success(orderList);
    }

    @ApiOperation("分页获取订单信息列表")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentOrder>> list(@RequestParam(value = "keyword", required = false) String keyword,
                                                     @RequestParam(value = "username", required = false) String username,
                                                     @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                     @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentOrder> orderList = orderService.list(keyword, username, pageSize, pageNum);
        return CommonResult.success(orderList);
    }

    @ApiOperation("获取指定订单信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<ReagentOrder> getItem(@PathVariable Long id) {
        ReagentOrder order = orderService.getItem(id);
        return CommonResult.success(order);
    }

    @ApiOperation("订单计数")
    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<String> count() {
        String orderCount = orderService.orderCount();
        return CommonResult.success(orderCount);
    }

    @ApiOperation("获取用户角色ID")
    @RequestMapping(value = "/getRoleId/{username}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult<Integer> getRoleId(@PathVariable String username) {
        int roleId = orderService.getRoleId(username);
        return CommonResult.success(roleId);
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "撤销订单")
    @ApiOperation("撤销订单")
    @RequestMapping(value = "/revoke/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult revokeOrder(@PathVariable Long id) {
        int count = orderService.revokeOrder(id);
        return CommonResult.success(count);
    }

    @OperationLogAnnotation(operaModule = "订单管理", operaDesc = "关闭订单")
    @ApiOperation("关闭订单")
    @RequestMapping(value = "/close/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult closeOrder(@PathVariable Long id) {
        int count = orderService.closeOrder(id);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

}