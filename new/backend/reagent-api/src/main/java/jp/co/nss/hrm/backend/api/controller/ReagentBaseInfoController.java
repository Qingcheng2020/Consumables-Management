package jp.co.nss.hrm.backend.api.controller;

import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import jp.co.nss.hrm.backend.api.aop.annotation.OperationLogAnnotation;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.api.service.ReagentBaseInfoService;
import jp.co.nss.hrm.backend.common.api.CommonPage;
import jp.co.nss.hrm.backend.common.api.CommonResult;
import jp.co.nss.hrm.backend.model.ReagentBaseInfo;
import jp.co.nss.hrm.backend.model.ReagentStock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * 试剂信息管理Controller
 * Created by macro on 2021/3/3.
 */
@Controller
@Api(tags = "ReagentBaseInfoController", description = "试剂信息管理")
@RequestMapping("/baseInfo")
public class ReagentBaseInfoController {
    @Autowired
    private ReagentBaseInfoService baseInfoService;

    @OperationLogAnnotation(operaModule = "试剂管理", operaDesc = "新增试剂")
    @ApiOperation("添加试剂信息")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult create(@RequestBody ReagentBaseInfo baseInfo) {
        int count = baseInfoService.create(baseInfo);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "试剂管理", operaDesc = "修改信息")
    @ApiOperation("修改试剂信息")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult update(@PathVariable Long id, @RequestBody ReagentBaseInfo baseInfo) {
        int count = baseInfoService.update(id, baseInfo);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "试剂管理", operaDesc = "删除试剂")
    @ApiOperation("删除指定试剂信息")
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult delete(@PathVariable Long id) {
        int count = baseInfoService.delete(id);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("获取所有试剂信息")
    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentBaseInfo>> listAll() {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.list();
        return CommonResult.success(baseInfoList);
    }


    @ApiOperation("获取是否使用二维码")
    @RequestMapping(value = "/getisQR", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<String> getisQR(@RequestBody ReagentStock reagentStock) {
        System.out.println("--------------------------------------------------------");
        System.out.println(reagentStock.toString());
        System.out.println("--------------------------------------------------------");
        String bool=baseInfoService.searchbycode(reagentStock);
        return CommonResult.success(bool);
    }

    @ApiOperation("分页获取试剂信息列表")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentBaseInfo>> list(@RequestParam(value = "keyword", required = false) String keyword,
                                                          @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                          @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.list(keyword, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(baseInfoList));
    }

    @ApiOperation("分页获取未禁用供货商的试剂信息列表")
    @RequestMapping(value = "/fetchEnSupList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentInfo>> fetchEnSupList(@RequestParam(value = "keyword", required = false) String keyword,
                                                              @RequestParam(value = "createBy", required = false) String createBy,
                                                              @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                              @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentInfo> baseInfoList = baseInfoService.fetchEnSupList(keyword, createBy, pageSize, pageNum);
        return CommonResult.success(baseInfoList);
    }


    @ApiOperation("获取指定试剂信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<ReagentBaseInfo> getItem(@PathVariable Long id) {
        ReagentBaseInfo baseInfo = baseInfoService.getItem(id);
        return CommonResult.success(baseInfo);
    }

    @ApiOperation("查询")
    @RequestMapping(value = "/searchList", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentBaseInfo>> searchList(@RequestParam(value = "code", required = false) String code,
                                                                @RequestParam(value = "name", required = false) String name,
                                                                @RequestParam(value = "manufacturerName", required = false) String manufacturerName,
                                                                @RequestParam(value = "supplierShortName", required = false) String supplierShortName,
                                                                @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                                @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.search(code, name, manufacturerName, supplierShortName, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(baseInfoList));
    }

    @ApiOperation("通过供应商名称区分权限")
    @RequestMapping(value = "/listBySupplier", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentBaseInfo>> listBySupplier(
            @RequestParam(value = "supplierShortName", required = false) String supplierShortName,
            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.searchBySupplier(supplierShortName, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(baseInfoList));
    }

    @ApiOperation("通过订单号查询信息")
    @RequestMapping(value = "/listByOrder", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<PageInfo<ReagentBaseInfo>> listByOrder(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        PageInfo<ReagentBaseInfo> baseInfoList = baseInfoService.searchByOrder(keyword, pageSize, pageNum);
        return CommonResult.success(baseInfoList);
    }

    @ApiOperation("通过供应商名称查询")
    @RequestMapping(value = "/searchBySupplier", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentBaseInfo>> searchBySupplier(
            @RequestParam(value = "supplierShortName", required = false) String supplierShortName,
            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.searchBaseInfo(supplierShortName, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(baseInfoList));
    }

    @OperationLogAnnotation(operaModule = "试剂管理", operaDesc = "一键导入")
    @ApiOperation("一键导入试剂信息")
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult<CommonPage<ReagentBaseInfo>> fileUpload(@RequestParam("file") MultipartFile file) throws IOException, InterruptedException {
        List<ReagentBaseInfo> baseInfoList = baseInfoService.fileUpload(file);
        return CommonResult.success(CommonPage.restPage(baseInfoList));
    }
}