package jp.co.nss.hrm.backend.api.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminDao;
import jp.co.nss.hrm.backend.api.dao.ReagentAdminRoleRelationDao;
import jp.co.nss.hrm.backend.api.dao.ReagentStockDao;
import jp.co.nss.hrm.backend.api.dao.ReagentStockDetailDao;
import jp.co.nss.hrm.backend.api.dto.AdminUserDetails;
import jp.co.nss.hrm.backend.api.dto.ReagentAdminParam;
import jp.co.nss.hrm.backend.api.dto.UpdateAdminPasswordParam;
import jp.co.nss.hrm.backend.api.service.ReagentAdminService;
import jp.co.nss.hrm.backend.common.exception.Asserts;
import jp.co.nss.hrm.backend.common.util.RequestUtil;
import jp.co.nss.hrm.backend.mapper.ReagentAdminLoginLogMapper;
import jp.co.nss.hrm.backend.mapper.ReagentAdminMapper;
import jp.co.nss.hrm.backend.mapper.ReagentAdminRoleRelationMapper;
import jp.co.nss.hrm.backend.model.*;
import jp.co.nss.hrm.backend.security.util.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * ReagentAdminService?????????
 * Created by macro on 2018/4/26.
 */
@Service
public class ReagentAdminServiceImpl implements ReagentAdminService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ReagentAdminServiceImpl.class);
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private ReagentAdminMapper adminMapper;
    @Autowired
    private ReagentAdminRoleRelationMapper adminRoleRelationMapper;
    @Autowired
    private ReagentAdminRoleRelationDao adminRoleRelationDao;
    @Autowired
    private ReagentAdminLoginLogMapper loginLogMapper;
    @Autowired
    private ReagentAdminDao adminDao;
    @Autowired
    private ReagentAdminRoleRelationDao adminRoleDao;

    @Override
    public ReagentAdmin getAdminByUsername(String username) {
        ReagentAdmin admin;
        ReagentAdminExample example = new ReagentAdminExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<ReagentAdmin> adminList = adminMapper.selectByExample(example);
        if (adminList != null && adminList.size() > 0) {
            admin = adminList.get(0);
            return admin;
        }
        return null;
    }

    @Override
    public ReagentAdmin register(ReagentAdminParam ReagentAdminParam) {
        ReagentAdmin ReagentAdmin = new ReagentAdmin();
        BeanUtils.copyProperties(ReagentAdminParam, ReagentAdmin);
        ReagentAdmin.setCreateTime(new Date());
        ReagentAdmin.setLoginTime(new Date());
        ReagentAdmin.setStatus(1);
        //???????????????????????????????????????
        ReagentAdminExample example = new ReagentAdminExample();
        example.createCriteria().andUsernameEqualTo(ReagentAdmin.getUsername());
        List<ReagentAdmin> ReagentAdminList = adminMapper.selectByExample(example);
        if (ReagentAdminList.size() > 0) {
            return null;
        }
        //???????????????????????????
        String encodePassword = passwordEncoder.encode(ReagentAdmin.getPassword());
        ReagentAdmin.setPassword(encodePassword);
        adminMapper.insert(ReagentAdmin);
        Long adminId = adminDao.selectByUser(ReagentAdmin.getUsername());

        //????????????????????????????????????????????????????????????-?????????????????????????????????????????????????????????
        Long createAdminId = adminDao.selectByUser(ReagentAdminParam.getCreateBy());
        Long createRoleId = adminRoleDao.selectByAdmin(createAdminId);
        long roleId;
        if (createRoleId == 2 || createRoleId == 6) {
            roleId = 5L;
        } else {
            roleId = 10L;
        }
        adminRoleDao.insertRoleId(adminId, roleId);
        return ReagentAdmin;
    }

    @Override
    public String login(String username, String password) {
        String token = null;
        //????????????????????????????????????
        try {
            UserDetails userDetails = loadUserByUsername(username);
            if (!passwordEncoder.matches(password, userDetails.getPassword())) {
                Asserts.fail("???????????????");
            }
            if (!userDetails.isEnabled()) {
                Asserts.fail("??????????????????");
            }
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            token = jwtTokenUtil.generateToken(userDetails);
            //updateLoginTimeByUsername(username);
            insertLoginLog(username);
        } catch (AuthenticationException e) {
            LOGGER.warn("????????????:{}", e.getMessage());
        }

        return token;
    }

    /**
     * ??????????????????
     *
     * @param username ?????????
     */
    private void insertLoginLog(String username) {
        ReagentAdmin admin = getAdminByUsername(username);
        if (admin == null) return;
        ReagentAdminLoginLog loginLog = new ReagentAdminLoginLog();
        loginLog.setAdminId(admin.getId());
        loginLog.setCreateTime(new Date());
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        loginLog.setIp(RequestUtil.getRequestIp(request));
        loginLogMapper.insert(loginLog);
    }

    /**
     * ?????????????????????????????????
     */
    private void updateLoginTimeByUsername(String username) {
        ReagentAdmin record = new ReagentAdmin();
        record.setLoginTime(new Date());
        ReagentAdminExample example = new ReagentAdminExample();
        example.createCriteria().andUsernameEqualTo(username);
        adminMapper.updateByExampleSelective(record, example);
    }

    @Override
    public String refreshToken(String oldToken) {
        return jwtTokenUtil.refreshHeadToken(oldToken);
    }

    @Override
    public ReagentAdmin getItem(Long id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<ReagentAdmin> getTrueName(String username) {
        ReagentAdminExample example = new ReagentAdminExample();
        ReagentAdminExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        return adminMapper.selectByExample(example);
    }

    @Override
    public PageInfo<ReagentAdmin> list(String keyword, String username, Integer pageSize, Integer pageNum) {
        ReagentAdminExample example = new ReagentAdminExample();
        ReagentAdminExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(keyword)) {
            criteria.andUsernameLike("%" + keyword + "%");
            example.or(example.createCriteria().andTrueNameLike("%" + keyword + "%"));
        }
        PageInfo<ReagentAdmin> adminList = PageHelper.startPage(pageNum, pageSize).doSelectPageInfo(() -> {
            adminMapper.selectByExample(example);
        });
        // ????????????list?????????????????????
        List<ReagentAdmin> collect = adminMapper.selectByExample(example);
        //??????Page???
        Page<ReagentAdmin> page = new Page<>(pageNum, pageSize);
        int total;

        //???????????????????????????ID???????????????ID????????????ID???
        //??????????????????????????????????????????????????????????????????????????????????????????
        Long adminId = adminDao.selectByUser(username);
        Long roleId = adminRoleDao.selectByAdmin(adminId);
        List<ReagentAdmin> adminOfList = new ArrayList<>();

        //?????????????????????????????????????????????????????????????????????????????????
        if (roleId == 7) {
            collect.forEach(adminItem -> {
                Long adminIdIndex = adminDao.selectByUser(adminItem.getUsername());
                Long roleIdIndex = adminRoleDao.selectByAdmin(adminIdIndex);
                if (roleIdIndex == 2 || roleIdIndex == 4 || roleIdIndex == 5 || roleIdIndex == 7 || roleIdIndex == 10) {
                    adminOfList.add(adminItem);
                }
            });
            //???Page?????????total????????????
            total = adminOfList.size();
            page.setTotal(total);
            //????????????????????????????????????????????????
            int startIndex = (pageNum - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, total);
            page.addAll(adminOfList.subList(startIndex, endIndex));
            //???Page??????PageInfo
            return new PageInfo<>(page);
        } else if (roleId == 8) {
            //????????????????????????????????????????????????????????????
            collect.forEach(adminItem -> {
                Long adminIdIndex = adminDao.selectByUser(adminItem.getUsername());
                Long roleIdIndex = adminRoleDao.selectByAdmin(adminIdIndex);
                if (roleIdIndex == 3 || roleIdIndex == 5 || roleIdIndex == 6 || roleIdIndex == 8 || roleIdIndex == 9 || roleIdIndex == 10) {
                    adminOfList.add(adminItem);
                }
            });
            //???Page?????????total????????????
            total = adminOfList.size();
            page.setTotal(total);
            //????????????????????????????????????????????????
            int startIndex = (pageNum - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, total);
            page.addAll(adminOfList.subList(startIndex, endIndex));
            //???Page??????PageInfo
            return new PageInfo<>(page);
        } else if (roleId == 2 || roleId == 6) {
            //???????????????????????????????????????-??????????????????????????????
            collect.forEach(adminItem -> {
                Long adminIdIndex = adminDao.selectByUser(adminItem.getUsername());
                Long roleIdIndex = adminRoleDao.selectByAdmin(adminIdIndex);
                if (roleIdIndex == 5) {
                    adminOfList.add(adminItem);
                }
            });
            //???Page?????????total????????????
            total = adminOfList.size();
            page.setTotal(total);
            //????????????????????????????????????????????????
            int startIndex = (pageNum - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, total);
            page.addAll(adminOfList.subList(startIndex, endIndex));
            //???Page??????PageInfo
            return new PageInfo<>(page);
        } else {
            //????????????
            return adminList;
        }
    }

    @Override
    public int update(Long id, ReagentAdmin admin, String username) {
        admin.setId(id);
        ReagentAdmin rawAdmin = adminMapper.selectByPrimaryKey(id);
        if (rawAdmin.getPassword().equals(admin.getPassword())) {
            //??????????????????????????????????????????
            admin.setPassword(null);
        } else {
            //?????????????????????????????????????????????
            if (StrUtil.isEmpty(admin.getPassword())) {
                admin.setPassword(null);
            } else {
                admin.setPassword(passwordEncoder.encode(admin.getPassword()));
            }
        }

        //????????????id
        Long roleId = adminRoleRelationDao.selectByAdmin(id);
        //?????????id
        if (username != null) {
            Long adminId = adminDao.selectByUser(username);
            Long manId = adminRoleDao.selectByAdmin(adminId);
            if ((manId == 7 || manId == 8) && (roleId == 7 || roleId == 8)) {
                //???????????????????????????????????????????????????
                return 3;
            }
        }
        //???????????????
        if (roleId == 1 && admin.getStatus() == 0) {
            return 2;
        }
        int count = adminMapper.updateByPrimaryKeySelective(admin);
        return count;
    }

    @Override
    public int delete(Long id) {
        int count = adminMapper.deleteByPrimaryKey(id);
        return count;
    }

    @Override
    public int updateRole(Long adminId, List<Long> roleIds) {
        int count = roleIds == null ? 0 : roleIds.size();
        //????????????????????????
        ReagentAdminRoleRelationExample adminRoleRelationExample = new ReagentAdminRoleRelationExample();
        adminRoleRelationExample.createCriteria().andAdminIdEqualTo(adminId);
        adminRoleRelationMapper.deleteByExample(adminRoleRelationExample);
        //???????????????
        if (!CollectionUtils.isEmpty(roleIds)) {
            List<ReagentAdminRoleRelation> list = new ArrayList<>();
            for (Long roleId : roleIds) {
                ReagentAdminRoleRelation roleRelation = new ReagentAdminRoleRelation();
                roleRelation.setAdminId(adminId);
                roleRelation.setRoleId(roleId);
                list.add(roleRelation);
            }
            adminRoleRelationDao.insertList(list);
        }
        return count;
    }

    @Override
    public List<ReagentRole> getRoleList(Long adminId) {
        return adminRoleRelationDao.getRoleList(adminId);
    }

    @Override
    public List<ReagentResource> getResourceList(Long adminId) {
        List<ReagentResource> resourceList;
        resourceList = adminRoleRelationDao.getResourceList(adminId);
        if (CollUtil.isNotEmpty(resourceList)) {
            //adminCacheService.setResourceList(adminId, resourceList);
        }
        return resourceList;
    }

    @Override
    public int updatePassword(UpdateAdminPasswordParam param) {
        if (StrUtil.isEmpty(param.getUsername())
                || StrUtil.isEmpty(param.getOldPassword())
                || StrUtil.isEmpty(param.getNewPassword())) {
            return -1;
        }
        ReagentAdminExample example = new ReagentAdminExample();
        example.createCriteria().andUsernameEqualTo(param.getUsername());
        System.out.println(param.getUsername());
        List<ReagentAdmin> adminList = adminMapper.selectByExample(example);
        if (CollUtil.isEmpty(adminList)) {
            return -2;
        }
        ReagentAdmin ReagentAdmin = adminList.get(0);
        if (!passwordEncoder.matches(param.getOldPassword(), ReagentAdmin.getPassword())) {
            return -3;
        }
        ReagentAdmin.setPassword(passwordEncoder.encode(param.getNewPassword()));
        adminMapper.updateByPrimaryKey(ReagentAdmin);
        return 1;
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        //??????????????????
        ReagentAdmin admin = getAdminByUsername(username);
        if (admin != null) {
            List<ReagentResource> resourceList = getResourceList(admin.getId());
            return new AdminUserDetails(admin, resourceList);
        }
        throw new UsernameNotFoundException("????????????????????????");
    }

    /**
     * ??????????????????????????????????????????
     * ?????????????????????????????????????????????
     *
     * @param usernameCurrent ?????????????????????
     * @param usernameTarget  ????????????
     * @return 0-????????????1-??????
     */
    @Override
    public int checkUserFromBranch(String usernameCurrent, String usernameTarget) {
        String branch = adminDao.selectBranch(usernameCurrent);

        return adminDao.checkUserFromBranch(branch, usernameTarget);
    }

    @Override
    public List<ReagentAdmin> getOperatorList(String branch) {
        return adminDao.getOperatorList(branch);
    }

}
