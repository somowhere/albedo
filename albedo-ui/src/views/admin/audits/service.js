import request from '@/router/axios'

export function findAllAudits(params) {
  return request({
    url: `../management/audits`,
    method: 'get',
    params: params
  })
}

