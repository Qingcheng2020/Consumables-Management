package jp.co.nss.hrm.backend.mapper;

import java.util.List;
import jp.co.nss.hrm.backend.model.ReagentCollect;
import jp.co.nss.hrm.backend.model.ReagentCollectExample;
import org.apache.ibatis.annotations.Param;

public interface ReagentCollectMapper {
    long countByExample(ReagentCollectExample example);

    int deleteByExample(ReagentCollectExample example);

    int deleteByPrimaryKey(Long id);

    int insert(ReagentCollect record);

    int insertSelective(ReagentCollect record);

    List<ReagentCollect> selectByExample(ReagentCollectExample example);

    ReagentCollect selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") ReagentCollect record, @Param("example") ReagentCollectExample example);

    int updateByExample(@Param("record") ReagentCollect record, @Param("example") ReagentCollectExample example);

    int updateByPrimaryKeySelective(ReagentCollect record);

    int updateByPrimaryKey(ReagentCollect record);

    int changeStatus(@Param("id") Long id);
}