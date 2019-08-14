import request from '@/router/axios'

export function findHealth() {
  return request({
    url: `/../management/health`,
    method: 'get'
  })
}

export function transformHealthData(data) {
  const response = [];
  flattenHealthData(response, null, data);
  return response;
}

export function getBaseName(name) {
  if (name) {
    const split = name.split('.');
    return split[0];
  }
}

export function getSubSystemName(name) {
  if (name) {
    const split = name.split('.');
    split.splice(0, 1);
    const remainder = split.join('.');
    return remainder ? ' - ' + remainder : '';
  }
}

/* private methods */
function addHealthObject(result, isLeaf, healthObject, name) {
  const healthData = {
    name
  };

  const details = {};
  let hasDetails = false;

  for (const key in healthObject) {
    if (healthObject.hasOwnProperty(key)) {
      const value = healthObject[key];
      if (key === 'status' || key === 'error') {
        healthData[key] = value;
      } else {
        if (!isHealthObject(value)) {
          details[key] = value;
          hasDetails = true;
        }
      }
    }
  }

  // Add the details
  if (hasDetails) {
    healthData.details = details;
  }

  // Only add nodes if they provide additional information
  if (isLeaf || hasDetails || healthData.error) {
    result.push(healthData);
  }
  return healthData;
}

function flattenHealthData(result, path, data) {
  // console.log(data)
  let val = data.details ? data.details : data;
  for (const key in val) {
    if (val.hasOwnProperty(key)) {
      const value = val[key];
      if (isHealthObject(value)) {
        if (hasSubSystem(value)) {
          addHealthObject(result, false, value, getModuleName(path, key));
          flattenHealthData(result, getModuleName(path, key), value);
        } else {
          addHealthObject(result, true, value, getModuleName(path, key));
        }
      }
    }
  }
  return result;
}

function getModuleName(path, name) {
  let result;
  if (path && name) {
    result = path + "." + name;
  } else if (path) {
    result = path;
  } else if (name) {
    result = name;
  } else {
    result = '';
  }
  return result;
}

function hasSubSystem(healthObject) {
  let result = false;

  for (const key in healthObject) {
    if (healthObject.hasOwnProperty(key)) {
      const value = healthObject[key];
      if (value && value.status) {
        result = true;
      }
    }
  }
  return result;
}

function isHealthObject(healthObject) {
  let result = false;

  for (const key in healthObject) {
    if (healthObject.hasOwnProperty(key)) {
      if (key === 'status') {
        result = true;
      }
    }
  }
  return result;
}

