import request from '@/router/axios';
import {isValidateUnique, toStr} from "@/util/validate";

export function fetchTestTreeBookTree(query) {
  return request({
    url: '/test/test-tree-book/tree',
    method: 'get',
    params: query
  })
}

export function pageTestTreeBook(query) {
  return request({
    url: '/test/test-tree-book/',
    method: 'get',
    params: query
  })
}

export function saveTestTreeBook(obj) {
  return request({
    url: '/test/test-tree-book/',
    method: 'post',
    data: obj
  })
}

export function findTestTreeBook(id) {
  return request({
    url: '/test/test-tree-book/' + id,
    method: 'get'
  })
}

export function removeTestTreeBook(id) {
  return request({
    url: '/test/test-tree-book/' + id,
    method: 'delete'
  })
}

export function validateUniqueTestTreeBook(rule, value, callback, id) {
  isValidateUnique(rule, value, callback, '/test/test-tree-book/checkByProperty?id=' + toStr(id))
}
