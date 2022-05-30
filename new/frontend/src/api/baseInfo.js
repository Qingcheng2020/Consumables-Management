import request from '@/utils/request'

export function getIsQr(data) {
  return request({
    url: '/baseInfo/getisQR',
    method: 'post',
    data: data
  })
}

export function fetchList(params) {
  return request({
    url: '/baseInfo/list',
    method: 'get',
    params: params
  })
}

export function fetchEnSupList(params) {
  return request({
    url: '/baseInfo/fetchEnSupList',
    method: 'get',
    params: params
  })
}

export function fetchListBySupplier(params) {
  return request({
    url: '/baseInfo/listBySupplier',
    method: 'get',
    params: params
  })
}

export function fetchListByOrder(params) {
  return request({
    url: '/baseInfo/listByOrder',
    method: 'get',
    params: params
  })
}

export function searchBySupplier(params) {
  return request({
    url: '/baseInfo/searchBySupplier',
    method: 'get',
    params: params
  })
}

export function searchList(params) {
  return request({
    url: '/baseInfo/searchList',
    method: 'get',
    params: params
  })
}

export function createBaseInfo(data) {
  return request({
    url: '/baseInfo/create',
    method: 'post',
    data: data
  })
}
export function handleLoad(params) {
  return request({
    url: '/baseInfo/xlsPath',
    method: 'get',
    params: params
  })
}

export function updateBaseInfo(id, data) {
  return request({
    url: '/baseInfo/update/' + id,
    method: 'post',
    data: data
  })
}


export function deleteBaseInfo(id) {
  return request({
    url: '/baseInfo/delete/' + id,
    method: 'post'
  })
}


export function fetchAllBaseInfoList() {
  return request({
    url: '/baseInfo/listAll',
    method: 'get'
  })
}

export function lowAndOverdue(reagentId) {
  return request({
    url: '/baseInfo/' + reagentId,
    method: 'get'
  });
}



