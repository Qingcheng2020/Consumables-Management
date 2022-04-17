import request from '@/utils/request'

export function fetchList(params) {
  return request({
    url: '/stock/list',
    method: 'get',
    params: params
  })
}

export function createStock(data) {
  return request({
    url: '/stock/create',
    method: 'post',
    data: data
  })
}

export function updateStock(id, data) {
  return request({
    url: '/stock/update/' + id,
    method: 'post',
    data: data
  })
}

export function outFromBranchStock(data) {
  return request({
    url: '/stock/outFromBranch/',
    method: 'post',
    data: data
  })
}

export function getStockCount() {
  return request({
    url: '/stock/count',
    method: 'get'
  })
}


export function deleteStock(id) {
  return request({
    url: '/stock/delete/' + id,
    method: 'post'
  })
}


export function fetchAllStockList() {
  return request({
    url: '/stock/listAll',
    method: 'get'
  })
}

export function searchList(params) {
  return request({
    url: '/stock/searchList',
    method: 'get',
    params: params
  })
}

export function relocationList(params) {
  return request({
    url: '/stock/relocationList',
    method: 'get',
    params: params
  })
}
export function searchLowList(params) {
  return request({
    url: '/stock/searchLowList',
    method: 'get',
    params: params
  })
}

