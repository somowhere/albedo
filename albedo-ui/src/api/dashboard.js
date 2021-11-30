import request from '@/utils/request'

const apiList = {
  getChart: `/dashboard/chart`,
  getItem: `/dashboard/item`
}

export default {
  getChart(data) {
    return request({
      method: 'GET',
      url: apiList.getChart,
      data
    })
  },
  getItem(data) {
    return request({
      method: 'GET',
      url: apiList.getItem,
      data
    })
  }
}
