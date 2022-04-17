import request from '@/utils/request'
import request2 from '@/utils/request'

export function fetchList(data) {
  return request({
    url: '/stockDetail/list',
    method: 'post',
    data: data
  })
}

export function fetchSearch(data) {
  return request({
    url: '/stockDetail/fetchSearch',
    method: 'post',
    data: data
  })
}

export function fetchLossList(params) {
  return request({
    url: '/stockDetail/lossList',
    method: 'get',
    params: params
  })
}

export function getStockList(params) {
  return request({
    url: '/stock/getItemBySN',
    method: 'get',
    params: params
  })
}

export function getStockDetail(stockNo) {
  return request({
    url: '/stockDetail/' + stockNo,
    method: 'get'
  });
}

export function updateStockDetail(id, data) {
  return request({
    url: '/stockDetail/update/' + id,
    method: 'post',
    data: data
  })
}

export function deleteStockDetail(allocId) {
  return request({
    url: '/stockDetail/delete/' + allocId,
    method: 'post',
    data: allocId
  })
}

export function updateStatus(data) {
  return request({
    url: '/stockDetail/updateStatus',
    method: 'post',
    data: data
  })
}

export function countLoss(params) {
  return request({
    url: '/stockDetail/countLoss',
    method: 'get',
    params: params
  })
}

export function countOutIn(params) {
  return request({
    url: '/stockDetail/countOutIn',
    method: 'get',
    params: params
  })
}

export function reagentOutIn(params) {
  return request({
    url: '/stockDetail/reagentOutIn',
    method: 'get',
    params: params
  })
}

export function reagentOverall(params) {
  return request({
    url: '/stockDetail/reagentOverall',
    method: 'get',
    params: params
  })
}

export function reagentUseLog(params) {
  return request({
    url: '/stockDetail/reagentUseLog',
    method: 'get',
    params: params
  })
}

export function isInStock(code) {
  return request({
    url: '/stockDetail/isInStock/' + code,
    method: 'post'
  })
}

export function isSupInStock(shortName) {
  return request({
    url: '/stockDetail/isSupInStock/' + shortName,
    method: 'post'
  })
}

export function lossSummary(params) {
  return request({
    url: '/stockDetail/lossSummary',
    method: 'get',
    params: params
  })
}

export function getIsQR(id) {
  return request2({
    url: '/baseInfo/getisQR' + id,
    method: 'get'
  })
}
