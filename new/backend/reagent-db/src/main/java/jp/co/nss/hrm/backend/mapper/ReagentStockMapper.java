package jp.co.nss.hrm.backend.mapper;

import java.util.List;
import java.util.Map;

import jp.co.nss.hrm.backend.model.ReagentStock;
import jp.co.nss.hrm.backend.model.ReagentCollectDetail;
import jp.co.nss.hrm.backend.model.ReagentStockDetail;
import jp.co.nss.hrm.backend.model.ReagentStockExample;
import org.apache.ibatis.annotations.Param;

public interface ReagentStockMapper {
    long countByExample(ReagentStockExample example);

    int deleteByExample(ReagentStockExample example);

    int deleteByPrimaryKey(Long id);

    int insert(ReagentStock record);

    int insertSelective(ReagentStock record);

    List<ReagentStock> selectByExample(ReagentStockExample example);

    ReagentStock selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") ReagentStock record, @Param("example") ReagentStockExample example);

    int updateByExample(@Param("record") ReagentStock record, @Param("example") ReagentStockExample example);

    int updateByPrimaryKeySelective(ReagentStock record);

    int updateByPrimaryKey(ReagentStock record);

    int outFromBranch(@Param("stock_no") String stock_no, @Param("Number") Long Number, @Param("name")String name);

    ReagentStock selectByReagentId(@Param("reagentid") String reagentid, @Param("destination") String destination);

    int outFromCentre(@Param("branch")String branch,@Param("reagentcode")String reagentcode,@Param("number")Long number);

    List<Map<String,Long>> getdata(@Param("id")Long id);

    String findhead(@Param("name")String name);

    String getregistration(@Param("reagentId")String reagentId);

    List<Map<String,String>> findfrombranch(@Param("stock_no") String stock_no, @Param("Number") Long Number, @Param("name")String name);

    List<Map<String,Object>> findFromCentre(@Param("branch")String branch,@Param("reagentcode")String reagentcode,@Param("number")Long number);
}