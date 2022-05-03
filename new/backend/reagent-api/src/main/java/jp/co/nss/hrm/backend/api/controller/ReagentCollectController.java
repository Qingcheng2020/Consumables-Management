package jp.co.nss.hrm.backend.api.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import jp.co.nss.hrm.backend.api.aop.annotation.OperationLogAnnotation;
import jp.co.nss.hrm.backend.api.dto.ReagentCollectPost;
import jp.co.nss.hrm.backend.api.dto.ReagentStatus;
import jp.co.nss.hrm.backend.api.service.ReagentCollectService;
import jp.co.nss.hrm.backend.common.api.CommonPage;
import jp.co.nss.hrm.backend.common.api.CommonResult;
import jp.co.nss.hrm.backend.model.ReagentCollect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.alibaba.fastjson.JSONObject;
import java.util.List;

/**
 * 领用管理管理Controller
 * Created by macro on 2021/3/31.
 */
@Controller
@Api(tags = "ReagentCollectController", description = "领用管理")
@RequestMapping("/collect")
public class ReagentCollectController {
    @Autowired
    private ReagentCollectService collectService;

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "新增")
    @ApiOperation("添加领用申请信息")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult create(@RequestBody ReagentCollectPost collect) {
        int count = collectService.create(collect);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "pda移库/申领入库")
    @ApiOperation("pda移库/申领入库")
    @RequestMapping(value = "/pda/relocation", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult relocation(@RequestBody ReagentCollectPost collect) {
        int count = collectService.relocation(collect);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("根据申请单类型查询申请单")
    @RequestMapping(value = "/inList/{applyType}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentCollect>> getAllByApplyType(@PathVariable String applyType) {
        List<ReagentCollect> collectList = collectService.getAllByApplyType(applyType);
        return CommonResult.success(collectList);
    }

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "修改申请单")
    @ApiOperation("修改领用申请单信息")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult update(@PathVariable Long id, @RequestBody ReagentCollect collect) {
        int count = collectService.update(id, collect);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "修改状态")
    @ApiOperation("根据入库单号修改入库单状态")
    @RequestMapping(value = "/updateByCN/{collectNo}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateByCN(@PathVariable String collectNo, @RequestBody ReagentCollect collect) {
        int count = collectService.updateByCN(collectNo, collect);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "删除申请单")
    @ApiOperation("删除领用申请单")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult delete(@RequestParam("ids") List<Long> ids) {
        int count = collectService.delete(ids);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @OperationLogAnnotation(operaModule = "领用管理", operaDesc = "删除单据")
    @ApiOperation("删除订单")
    @RequestMapping(value = "/deleteByCoNo", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult deleteCollectByNo(@RequestParam("collectNo") String collectNo) {

        int count = collectService.deleteByCollectNo(collectNo);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @ApiOperation("获取所有领用信息")
    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<List<ReagentCollect>> listAll() {
        List<ReagentCollect> collectList = collectService.list();
        return CommonResult.success(collectList);
    }

    @ApiOperation("分页获取领用申请单信息列表")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentCollect>> list(@RequestParam(value = "applyType", required = false) String applyType,
                                                         @RequestParam(value = "keyword", required = false) String keyword,
                                                         @RequestParam(value = "username", required = false) String username,
                                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                         @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentCollect> collectList = collectService.list(applyType, keyword, username, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(collectList));
    }

    @ApiOperation("获取指定领用申请单信息")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<ReagentCollect> getItem(@PathVariable Long id) {
        ReagentCollect collect = collectService.getItem(id);
        return CommonResult.success(collect);
    }

    @ApiOperation("组别领用报表")
    @RequestMapping(value = "/countCollect", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult<CommonPage<ReagentStatus>> countCollect(@RequestParam(value = "username", required = false) String username,
                                                                @RequestParam(value = "startTime", required = false) String startTime,
                                                                @RequestParam(value = "endTime", required = false) String endTime,
                                                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                                @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<ReagentStatus> collectList = collectService.countCollect(username, startTime, endTime, pageSize, pageNum);
        return CommonResult.success(CommonPage.restPage(collectList));
    }


    @OperationLogAnnotation(operaModule = "申请管理", operaDesc = "修改状态")
    @ApiOperation("手动完成申请")
    @RequestMapping(value = "/changeStatus", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult changeStatus(@RequestBody JSONObject itemId) {
        Long id= Long.valueOf(itemId.getString("itemId"));
        long count= collectService.changeStatus(id);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

}