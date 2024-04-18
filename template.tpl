___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Grow - Order Currency",
  "categories": ["ATTRIBUTION", "MARKETING", "PERSONALIZATION", "REMARKETING", "CONVERSIONS"],
  "description": "Captures the order currency from the data layer.\nCurrency must be in ISO 4217 format",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "currency",
    "displayName": "Order Currency - Required",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const queryPermission = require('queryPermission');
const copyFromDataLayer = require('copyFromDataLayer');

const rawKey = data.currency;
if (rawKey === undefined) return undefined;

const dlKey = rawKey.trim();
if (dlKey === '') return undefined;

if (queryPermission('read_data_layer', dlKey)) {
  const dlContents = copyFromDataLayer(dlKey);
  return dlContents;
} else {
  log('you dont have permission to read', dlKey);
  return false;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Returns currency from DL by given name
  code: |-
    const mockData = {
      currency: 'curr'
    };

    mock('copyFromDataLayer', function (key) {
      const map = {
            curr: 'BRL',
            currency: 'EUR'
          };
      return map[key];
    });

    const res = runCode(mockData);
    assertThat(res).isEqualTo('BRL');
- name: Returns undefined if currency is not set
  code: |-
    const mockData = {
    };

    mock('copyFromDataLayer', function (key) {
      const map = {
            id: 5,
            ordesadasrID: 2
          };
      return map[key];
    });

    const res = runCode(mockData);
    assertThat(res).isEqualTo(undefined);
- name: Returns undefined if currency is not empty
  code: |-
    const mockData = {
       currency: ''
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(undefined);
setup: ''


___NOTES___

Created on 11/04/2024, 14:09:50


