/**
 * @license Copyright 2017 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 */
'use strict';

module.exports = {
  extends: 'lighthouse:default',
  passes: [
    {
      passName: 'extraPass',
      gatherers: [
        'styles',
        'css-usage',
        'js-usage',
      ],
    },
    {
      passName: 'defaultPass',
      gatherers: [
        'seo/meta-description',
      ],
    }
  ],
  audits: [
    'byte-efficiency/unused-css-rules',
    'byte-efficiency/unused-javascript',
    'dobetterweb/no-old-flexbox',
    'seo/meta-description',
    'seo/http-status-code',
  ],
  groups: {
    'seo-mobile': {
      title: 'Mobile Friendly',
      description: 'Having a mobile-friendly website is a critical part of your online presence.' +
        ' In many countries, smartphone traffic now exceeds desktop traffic.',
    },
    'seo-content': {
      title: 'Content Best Practices',
      description: 'Ensure your markup enables crawlers to better understand your app\'s content.',
    },
    'seo-crawl': {
      title: 'Crawling and Indexing',
      description: 'These ensure that your app is able to be crawled.',
    },
  },
  categories: {
    'performance': {
      audits: [
        {id: 'unused-css-rules', weight: 0, group: 'perf-hint'},
        {id: 'unused-javascript', weight: 0, group: 'perf-hint'},
      ],
    },
    'best-practices': {
      audits: [
        {id: 'no-old-flexbox', weight: 1},
      ],
    },
    'seo': {
      name: 'SEO',
      description: 'These ensure your app is able to be understood by search engine crawlers.',
      audits: [
        {id: 'viewport', weight: 1, group: 'seo-mobile'},
        {id: 'document-title', weight: 1, group: 'seo-content'},
        {id: 'meta-description', weight: 1, group: 'seo-content'},
        {id: 'http-status-code', weight: 1, group: 'seo-crawl'},
      ],
    },
  },
};
