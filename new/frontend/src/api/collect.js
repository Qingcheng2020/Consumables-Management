import request from '@/utils/request'

export function fetchList(params) {
  return request({
    url: '/collect/list',
    method: 'get',
    params: params
  })
}

export function createCollectItem(data) {
  return request({
    url: '/collect/create',
    method: 'post',
    data: data
  })
}

export function applyInStock(data) {
  return request({
    url: '/collect/pda/relocation',
    method: 'post',
    data: data
  })
}

export function deleteCollect(params) {
  return request({
    url: '/collect/delete',
    method: 'post',
    params: params
  })
}

export function updateRelocationByCN(collectNo, data) {
  return request({
    url: '/collect/updateByCN/' + collectNo,
    method: 'post',
    data: data,
  })
}

export function deleteCollectByCoNo(params) {
  return request({
    url: '/collect/deleteByCoNo',
    method: 'post',
    params: {
      collectNo: params
    }
  })
}

export function getCollectDetail(id) {
  return request({
    url: '/collect/' + id,
    method: 'get'
  });
}
export function countCollect(params) {
  return request({
    url: '/collect/countCollect',
    method: 'get',
    params: params
  })
}

export function changeStatus(data) {
  return request({
    url: '/collect/changeStatus',
    method: 'post',
    data: data
  })
}
