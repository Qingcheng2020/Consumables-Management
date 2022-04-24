package jp.co.nss.hrm.backend.api.controller;

import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import jp.co.nss.hrm.backend.api.aop.annotation.OperationLogAnnotation;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.api.service.ReagentStockDetailService;
import jp.co.nss.hrm.backend.api.service.ReagentStockService;
import jp.co.nss.hrm.backend.common.api.CommonResult;
import jp.co.nss.hrm.backend.model.ReagentStock;
import jp.co.nss.hrm.backend.model.ReagentStockCentre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 中心库存信息管理Controller
 * Created by macro on 2021/3/8.
 */
@Controller
@Api(tags = "ReagentStockController", description = "在库管理")
@RequestMapping("/stock")
//@RequestMapping("/api/stock")
public class ReagentStockController {
    @Autowired
    private ReagentStockService stockService;
    @Autowired
    private ReagentStockDetailService stockDetailService;

    @ApiOperation("库存计数")
    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<String> count() {
        String stockCount = stockService.stockCount();
        return CommonResult.success(stockCount);
    }

    @OperationLogAnnotation(operaModule = "在库管理", operaDesc = "新增")
    @ApiOperation("添加中心库存信息")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult create(@RequestBody ReagentStock stock) {
        int count = stockService.create(stock);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "在库管理", operaDesc = "修改")
    @ApiOperation("修改中心库存信息")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult update(@PathVariable Long id, @RequestBody ReagentStock stock) {
        int count = stockService.update(id, stock);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }



    @OperationLogAnnotation(operaModule = "在库管理", operaDesc = "移库")
    @ApiOperation("移出科室库")
    @RequestMapping(value = "/outFromBranch", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult outFromBranch(@RequestBody ReagentStock stock) {

        int count = stockService.outFromBranch(stock);

        return CommonResult.success(1);
    }

    @OperationLogAnnotation(operaModule = "在库管理", operaDesc = "移库")
    @ApiOperation("移出中心库")
    @RequestMapping(value = "/outFromCentre", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult outFromCentre(@RequestBody ReagentStock stock) {

        int count = stockService.outFromCentre(stock);

        return CommonResult.success(count);
    }

    @OperationLogAnnotation(operaModule = "在库管理", operaDesc = "删除")
    @ApiOperation("删除指定中心库存信息")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult delete(@PathVariable Long id) {
        int count = stockService.delete(id);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("获取所有中心库存信息")
    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentStock>> listAll() {
        List<ReagentStock> stockList = stockService.list();
        return CommonResult.success(stockList);
    }

    @ApiOperation("分页检索")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentStock>> list(@RequestParam(value = "stockType", required = false) String stockType,
                                                 @RequestParam(value = "username", required = false) String username,
                                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                 @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentStock> stockList = stockService.list(stockType, username, pageSize, pageNum);
        return CommonResult.success(stockList);
    }

    @ApiOperation("在库检索")
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentInfo>> list(@RequestParam(value = "batchNo", required = false) String batchNo,
                                                @RequestParam(value = "qrCode", required = false) String qrCode) {

        List<ReagentInfo> infoList = stockService.searchStock(batchNo, qrCode);
        return CommonResult.success(infoList);
    }

    @ApiOperation("获取指定库存信息")
    @RequestMapping(value = "/getItemBySN", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentInfo>> getItemBySN(@RequestParam(value = "username", required = false) String username,
                                                       @RequestParam(value = "keyword", required = false) String keyword) {
        List<ReagentInfo> stock = stockService.getItemBySN(username, keyword);
        return CommonResult.success(stock);
    }

    @ApiOperation("查询")
    @RequestMapping(value = "/searchList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentStock>> searchList(@RequestParam(value = "stockType", required = false) String stockType,
                                                           @RequestParam(value = "reagentName", required = false) String reagentName,
                                                           @RequestParam(value = "supplierName", required = false) String supplierName,
                                                           @RequestParam(value = "factory", required = false) String factory,
                                                           @RequestParam(value = "reagentTemp", required = false) String reagentTemp,
                                                           @RequestParam(value = "username", required = false) String username,
                                                           @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                           @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentStock> stockList = stockService.search(stockType, reagentName, supplierName, factory, reagentTemp, username, pageSize, pageNum);
        return CommonResult.success(stockList);
    }

    @ApiOperation("移库领用列表查询")
    @RequestMapping(value = "/relocationList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentStock>> relocationList(@RequestParam(value = "stockType", required = false) String stockType,
                                                               @RequestParam(value = "username", required = false) String username,
                                                               @RequestParam(value = "applyType", required = false) String applyType,
                                                               @RequestParam(value = "keyword", required = false) String keyword,
                                                               @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                               @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentStock> stockList = stockService.relocationList(stockType, username, applyType, keyword, pageSize, pageNum);
        return CommonResult.success(stockList);
    }

    @ApiOperation("低预警查询")
    @RequestMapping(value = "/searchLowList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentStock>> searchLowList(@RequestParam(value = "type", required = false) Integer type,
                                                              @RequestParam(value = "reagentName", required = false) String reagentName,
                                                              @RequestParam(value = "supplierName", required = false) String supplierName,
                                                              @RequestParam(value = "factory", required = false) String factory,
                                                              @RequestParam(value = "reagentTemp", required = false) String reagentTemp,
                                                              @RequestParam(value = "username", required = false) String username,
                                                              @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                              @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentStock> stockList = stockService.searchLow(type, reagentName, supplierName, factory, reagentTemp, username, pageSize, pageNum);
        return CommonResult.success(stockList);
    }

    @ApiOperation("试剂操作员试剂查询")
    @RequestMapping(value = "/list/operator", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentStock>> getOperatorList(@RequestParam(value = "username") String username,
                                                            @RequestParam(value = "stockType") String stockType) {
        List<ReagentStock> stockList = stockDetailService.getOperatorList(username, stockType);
        return CommonResult.success(stockList);
    }



}
