package jp.co.nss.hrm.backend.api.service;

import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.model.ReagentBaseInfo;
import jp.co.nss.hrm.backend.model.ReagentStock;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ReagentBaseInfoService {


    ReagentBaseInfo getItem(Long id);


    /**
     * 获取所有试剂信息列表
     */

    List<ReagentBaseInfo> list();

    /**
     * 添加试剂信息
     */
    int create(ReagentBaseInfo baseInfo);

    /**
     * 批量导入试剂信息
     */

    List<ReagentBaseInfo> fileUpload(MultipartFile file) throws IOException, InterruptedException;

    /**
     * 修改试剂信息
     */
    int update(Long id, ReagentBaseInfo baseInfo);

    /**
     * 删除指定试剂
     */
    int delete(Long id);

    /**
     * 分页获取试剂列表
     */
    List<ReagentBaseInfo> list(String keyword, Integer pageSize, Integer pageNum);

    /**
     * 获取供货商未被禁用的试剂列表
     */
    PageInfo<ReagentInfo> fetchEnSupList(String keyword, String createBy, Integer pageSize, Integer pageNum);

    /**
     * 组合查询
     */
    List<ReagentBaseInfo> search(String code, String name, String manufacturerName, String supplierShortName, Integer pageSize, Integer pageNum);

    /**
     * 根据供应商名字查询
     */
    List<ReagentBaseInfo> searchBySupplier(String supplierShortName, Integer pageSize, Integer pageNum);

    List<ReagentBaseInfo> searchBaseInfo(String supplierShortName, Integer pageSize, Integer pageNum);

    PageInfo<ReagentBaseInfo> searchByOrder(String keyword, Integer pageSize, Integer pageNum);

    String searchbycode(String reagentid);
}


