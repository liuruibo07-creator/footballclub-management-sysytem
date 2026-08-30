import request from '@/utils/request'

// 查询球队队徽列表(首页横幅与管理页共用)
export function listTeamLogo(query) {
  return request({
    url: '/match/teamlogo/list',
    method: 'get',
    params: query
  })
}

// 查询球队队徽详细
export function getTeamLogo(id) {
  return request({
    url: '/match/teamlogo/' + id,
    method: 'get'
  })
}

// 新增球队队徽
export function addTeamLogo(data) {
  return request({
    url: '/match/teamlogo',
    method: 'post',
    data: data
  })
}

// 修改球队队徽
export function updateTeamLogo(data) {
  return request({
    url: '/match/teamlogo',
    method: 'put',
    data: data
  })
}

// 删除球队队徽
export function delTeamLogo(id) {
  return request({
    url: '/match/teamlogo/' + id,
    method: 'delete'
  })
}
