package jp.co.nss.hrm.backend.mapper;

import java.util.List;
import jp.co.nss.hrm.backend.model.ReagentOrder;
import jp.co.nss.hrm.backend.model.ReagentOrderExample;
import org.apache.ibatis.annotations.Param;

public interface ReagentOrderMapper {
    long countByExample(ReagentOrderExample example);

    int deleteByExample(ReagentOrderExample example);

    int deleteByPrimaryKey(Long id);

    int insert(ReagentOrder record);

    int insertSelective(ReagentOrder record);

    List<ReagentOrder> selectByExample(ReagentOrderExample example);

    ReagentOrder selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") ReagentOrder record, @Param("example") ReagentOrderExample example);

    int updateByExample(@Param("record") ReagentOrder record, @Param("example") ReagentOrderExample example);

    int updateByPrimaryKeySelective(ReagentOrder record);

    int updateByPrimaryKey(ReagentOrder record);

    String getphonenum(@Param("num")String num);
}