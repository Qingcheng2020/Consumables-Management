package jp.co.nss.hrm.backend.api.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.*;
import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.api.dto.ReagentStockDetailReq;
import jp.co.nss.hrm.backend.api.service.ReagentBaseInfoService;
import jp.co.nss.hrm.backend.mapper.*;
import jp.co.nss.hrm.backend.model.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ReagentBaseInfoServiceImpl implements ReagentBaseInfoService {

    @Autowired
    private ReagentBaseInfoMapper baseInfoMapper;
    @Autowired
    private ReagentBaseInfoDao baseInfoDao;
    @Autowired
    private ReagentOrderDetailDao orderDetailDao;
    @Autowired
    private ReagentSupplierDao supplierDao;
    @Autowired
    private ReagentSupplierMapper supplierMapper;
    @Autowired
    private ReagentStockMapper stockMapper;
    @Autowired
    private ReagentStockDetailMapper stockDetailMapper;
    @Autowired
    private ReagentAdminDao adminDao;
    @Autowired
    private ReagentStockDao stockDao;
    @Autowired
    private ReagentProdQualificationMapper prodQualificationMapper;

    /**
     * 获取所有试剂信息
     */
    @Override
    public List<ReagentBaseInfo> list() {

        return baseInfoMapper.selectByExample(new ReagentBaseInfoExample());
    }

    /**
     * 添加试剂信息
     *
     * @param baseInfo
     */
    @Override
    public int create(ReagentBaseInfo baseInfo) {
        baseInfo.setCreateTime(new Date());

        String count;
        count = baseInfoDao.getMaxId();

        if (StringUtils.isEmpty(count)) count = "0";
        Integer newCount = Integer.parseInt(count) + 1;
        baseInfo.setCode(String.valueOf(newCount));

        //添加供应商id
        ReagentSupplierExample example = new ReagentSupplierExample();
        example.createCriteria().andSupplierShortNameEqualTo(baseInfo.getSupplierShortName());
        List<ReagentSupplier> supplierList = supplierMapper.selectByExample(example);
        String supplierId = supplierList.get(0).getSupplierCode();
        baseInfo.setSupplierId(supplierId);

        //写入产品资质表
        ReagentProdQualification prodQualification = new ReagentProdQualification();
        prodQualification.setSupplierId(supplierId);
        prodQualification.setSupplierShortName(baseInfo.getSupplierShortName());
        prodQualification.setReagentId(String.valueOf(newCount));
        prodQualification.setReagentName(baseInfo.getName());
        prodQualification.setCreateTime(new Date());
        prodQualification.setUpdateTime(new Date());

        prodQualificationMapper.insert(prodQualification);


        return baseInfoMapper.insert(baseInfo);
    }


    /**
     * 一键导入试剂信息
     */
    @Override
    public List<ReagentBaseInfo> fileUpload(MultipartFile file) throws IOException, InterruptedException {
        //调用Read.excel方法，传入file文件进行解析
        return excel(file);
    }

    public List<ReagentBaseInfo> excel(MultipartFile file) {
        //定义一个空数组
        List<ReagentBaseInfo> successList = new ArrayList<>();
        List<ReagentBaseInfo> errorList = new ArrayList<>();
        try {
            //创建一个 workbook 对象
            XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

            //获取Excel文档中的第一个表单
            Sheet sht0 = workbook.getSheetAt(0);
            //对Sheet中的每一行进行迭代
            for (Row row : sht0) {
                //如果当前行的行号（从0开始）未达到2（第三行）则从新循环
                if (row.getRowNum() < 2) {
                    continue;
                }
                //创建实体类
                ReagentBaseInfo baseInfo = new ReagentBaseInfo();

                //取出当前行第1个单元格数据，并封装在info实体属性上
                baseInfo.setName(row.getCell(0).getStringCellValue());//试剂名称
                baseInfo.setManufacturerName(row.getCell(1).getStringCellValue());//生产厂家
                baseInfo.setSpecification(row.getCell(2).getStringCellValue());//型号规格
                baseInfo.setUnit(row.getCell(3).getStringCellValue());//单位
                baseInfo.setRegistrationNo(row.getCell(4).getStringCellValue());//注册证号
                baseInfo.setSupplierShortName(row.getCell(5).getStringCellValue());//供货商(查ID)
                baseInfo.setStockType(row.getCell(6).getStringCellValue());//存储温度
                int cell7 = row.getCell(7).getCellType();
                int cell8 = row.getCell(8).getCellType();
                int cell9 = row.getCell(9).getCellType();
                int cell10 = row.getCell(10).getCellType();
                if (cell7 == Cell.CELL_TYPE_NUMERIC) {
                    baseInfo.setPrice(row.getCell(7).getNumericCellValue());//单价
                }
                if (cell8 == Cell.CELL_TYPE_NUMERIC) {
                    baseInfo.setExpirationLimit((int) row.getCell(8).getNumericCellValue());//过期预警时间阈值
                }
                if (cell9 == Cell.CELL_TYPE_NUMERIC) {
                    baseInfo.setStockLimit((int) row.getCell(9).getNumericCellValue());//低库存预警阈值
                }
                if (cell10 == Cell.CELL_TYPE_NUMERIC) {
                    baseInfo.setUseDayLimit((int) row.getCell(10).getNumericCellValue());//开启有效期
                }

                baseInfo.setCreateTime(new Date());//创建时间
                //添加供应商id（供货商禁用时ID查出来为null）
                String supplierId = supplierDao.getID(row.getCell(5).getStringCellValue()).replace(" ", "");
                baseInfo.setSupplierId(supplierId);
                //试剂编号
                String count;
                count = baseInfoDao.getMaxId();
                if (StringUtils.isEmpty(count)) count = "0";
                Integer newCount = Integer.parseInt(count) + 1;
                baseInfo.setCode(String.valueOf(newCount));

                //判断非空
                if (baseInfo.getSupplierId() == null || baseInfo.getName().equals("") || baseInfo.getManufacturerName().equals("") ||
                        baseInfo.getCode().equals("") || baseInfo.getStockType().equals("") || baseInfo.getSupplierShortName().equals("") ||
                        baseInfo.getSpecification().equals("") || baseInfo.getUnit().equals("") || baseInfo.getRegistrationNo().equals("") ||
                        baseInfo.getPrice() == null || baseInfo.getExpirationLimit() == null
                        || baseInfo.getUseDayLimit() == null || baseInfo.getStockLimit() == null) {
                    System.out.println("添加失败:" + baseInfo);
                    errorList.add(baseInfo);
                } else {
                    // 最后将解析后的全部合格的数据，添加到数据库中
                    System.out.println("添加成功:" + baseInfo);
                    baseInfoMapper.insert(baseInfo);

                    //写入产品资质表
                    ReagentProdQualification prodQualification = new ReagentProdQualification();
                    prodQualification.setSupplierId(supplierId);
                    prodQualification.setSupplierShortName(row.getCell(5).getStringCellValue());
                    prodQualification.setReagentId(String.valueOf(newCount));
                    prodQualification.setReagentName(row.getCell(0).getStringCellValue());
                    prodQualification.setCreateTime(new Date());
                    prodQualification.setUpdateTime(new Date());

                    prodQualificationMapper.insert(prodQualification);

                    successList.add(baseInfo);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return errorList;
    }


    /**
     * 修改试剂信息
     *
     * @param id
     * @param baseInfo
     */
    @Override
    public int update(Long id, ReagentBaseInfo baseInfo) {
        baseInfo.setId(id);
        baseInfo.setUpdateTime(new Date());

        //修改stock表阈值
        ReagentStockExample stockExample = new ReagentStockExample();
        stockExample.createCriteria().andReagentIdEqualTo(baseInfo.getCode());
        List<ReagentStock> stockList = stockMapper.selectByExample(stockExample);
        for (ReagentStock item : stockList) {
            item.setOverdue(baseInfo.getExpirationLimit());
            item.setLowStock(baseInfo.getStockLimit().toString());
            stockMapper.updateByPrimaryKeySelective(item);
        }

        //修改stockDetail表阈值
        ReagentStockDetailExample stockDetailExample = new ReagentStockDetailExample();
        stockDetailExample.createCriteria().andReagentIdEqualTo(baseInfo.getCode());
        List<ReagentStockDetail> stockDetailList = stockDetailMapper.selectByExample(stockDetailExample);
        for (ReagentStockDetail item : stockDetailList) {
            item.setOverdue(baseInfo.getExpirationLimit());
            stockDetailMapper.updateByPrimaryKeySelective(item);
        }

        //修改供应商id
        ReagentSupplierExample example = new ReagentSupplierExample();
        example.createCriteria().andSupplierShortNameEqualTo(baseInfo.getSupplierShortName());
        List<ReagentSupplier> supplierList = supplierMapper.selectByExample(example);
        String supplierId = supplierList.get(0).getSupplierCode();
        baseInfo.setSupplierId(supplierId);
        return baseInfoMapper.updateByPrimaryKeySelective(baseInfo);
    }

    /**
     * 删除指定试剂信息
     */

    @Override
    public int delete(Long id) {
        int count = baseInfoMapper.deleteByPrimaryKey(id);
        int updateId = baseInfoDao.updateId(id);
        return count;
    }

    /**
     * 分页获取试剂信息
     *
     * @param keyword
     * @param pageSize
     * @param pageNum
     */
    @Override
    public List<ReagentBaseInfo> list(String keyword, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        ReagentBaseInfoExample example = new ReagentBaseInfoExample();
        ReagentBaseInfoExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(keyword)) {
            criteria.andCodeLike("%" + keyword + "%");
            example.or(example.createCriteria().andNameLike("%" + keyword + "%"));
            example.or(example.createCriteria().andSupplierShortNameLike("%" + keyword + "%"));
        }
        return baseInfoMapper.selectByExample(example);
    }

    /**
     * 获取供货商未被禁用的试剂列表
     *
     * @param keyword
     * @param createBy
     * @param pageSize
     * @param pageNum
     */
    @Override
    public PageInfo<ReagentInfo> fetchEnSupList(String keyword, String createBy, Integer pageSize, Integer pageNum) {
        String branch = adminDao.selectBranch(createBy);

        List<ReagentInfo> baseInfoList = baseInfoDao.getEnSupList(keyword);
        for (ReagentInfo reagentInfo : baseInfoList) {
            reagentInfo.setStockNumber(0);
        }

        //创建Page类
        Page<ReagentInfo> page = new Page<>(pageNum, pageSize);
        int total;

        //筛选之前的全部
        List<ReagentStockDetailReq> stockListAll = stockDao.selectForPlace(branch);

        //库存不为空，更新试剂信息中的库存数量
        if (!stockListAll.isEmpty()) {
            for (ReagentInfo reagentInfo : baseInfoList) {
                for (ReagentStockDetailReq reagentStockDetailReq : stockListAll) {
                    if (reagentStockDetailReq.getReagentId().equals(reagentInfo.getReagentId().toString())) {
                        reagentInfo.setStockNumber(reagentStockDetailReq.getStockNumber());
                    }
                }
            }
        }

        //为Page类中的total属性赋值
        total = baseInfoList.size();
        page.setTotal(total);
        //计算当前需要显示的数据下标起始值
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(baseInfoList.subList(startIndex, endIndex));
        //以Page创建PageInfo
        return new PageInfo<>(page);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public ReagentBaseInfo getItem(Long id) {
        return baseInfoMapper.selectByPrimaryKey(id);
    }

    /**
     * @param code
     * @param name
     * @param manufacturerName
     * @param supplierShortName
     * @return
     */
    @Override
    public List<ReagentBaseInfo> search(String code, String name, String manufacturerName, String supplierShortName, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        return baseInfoDao.searchByDouble(code, name, manufacturerName, supplierShortName);
    }

    /**
     * @param supplierShortName
     * @return
     */
    @Override
    public List<ReagentBaseInfo> searchBySupplier(String supplierShortName, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        ReagentBaseInfoExample example = new ReagentBaseInfoExample();
        ReagentBaseInfoExample.Criteria criteria = example.createCriteria();
        criteria.andSupplierShortNameEqualTo(supplierShortName);
        return baseInfoMapper.selectByExample(example);
    }


    /**
     * @param keyword
     * @return 预入库单中新增试剂必须为此次下单列表中有的试剂, 用试剂编号进行匹配
     */
    @Override
    public PageInfo<ReagentBaseInfo> searchByOrder(String keyword, Integer pageSize, Integer pageNum) {
        List<ReagentOrderDetail> orderDetailList;
        List<ReagentBaseInfo> reagentBaseInfoAll;
        List<ReagentBaseInfo> reagentBaseInfo = new ArrayList<>();

        //codeList中存储试剂ID，用以决定添加到reagentBaseInfo中的试剂为唯一且不重复的
        List<String> codeList = new ArrayList<>();

        reagentBaseInfoAll = baseInfoMapper.selectByExample(new ReagentBaseInfoExample());
        orderDetailList = orderDetailDao.selectUnSendDetail(keyword);

        //创建Page类
        Page<ReagentBaseInfo> page = new Page<>(pageNum, pageSize);
        int total;

        for (ReagentBaseInfo baseInfo : reagentBaseInfoAll) {
            for (ReagentOrderDetail orderDetail : orderDetailList) {
                if (baseInfo.getCode().equals(orderDetail.getReagentCode()) && !codeList.contains(orderDetail.getReagentCode())) {
                    reagentBaseInfo.add(baseInfo);
                    codeList.add(orderDetail.getReagentCode());
                }
            }
        }
        //为Page类中的total属性赋值
        total = reagentBaseInfo.size();
        page.setTotal(total);
        //计算当前需要显示的数据下标起始值
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        page.addAll(reagentBaseInfo.subList(startIndex, endIndex));
        //以Page创建PageInfo
        return new PageInfo<>(page);
    }

    /**
     * @param supplierShortName
     * @return
     */
    @Override
    public List<ReagentBaseInfo> searchBaseInfo(String supplierShortName, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        ReagentBaseInfoExample example = new ReagentBaseInfoExample();
        ReagentBaseInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNameLike("%" + supplierShortName + "%");
        return baseInfoMapper.selectByExample(example);
    }
    @Override
    public String searchbycode(ReagentStock stock){
        Long id= Long.valueOf(stock.getReagentId());
        String isqr =baseInfoMapper.selectByPrimaryKey(id).getCode();
        return isqr;
    }
}
