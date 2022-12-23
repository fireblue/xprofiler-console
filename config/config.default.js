/* eslint valid-jsdoc: "off" */

'use strict';

const fs = require('fs');
const path = require('path');

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  config.keys = appInfo.name + '_1588763657594_4897';

  config.development = {
    watchDirs: ['lib'],
  };

  config.static = {
    gzip: true,
    dir: path.join(__dirname, '../app/public'),
  };

  config.siteFile = {
    '/favicon.ico': fs.readFileSync(path.join(__dirname, '../app/public/favicon.ico')),
  };

  config.view = {
    root: path.join(__dirname, '../app/view'),
    mapping: {
      '.html': 'nunjucks',
    },
  };

  config.security = {
    csrf: {
      ignore: [
        '/xapi/upload_from_xtransit',
      ],
    },
  };

  config.multipart = {
    fileSize: '4096mb',
    fileExtensions: [
      '.cpuprofile',
      '.heapprofile',
      '.gcprofile',
      '.heapsnapshot',
      '.diag',
      '.core',
      '.node',
      '.trend',
    ],
    mode: 'file',
  };

  config.secure = {
    secret: 'easy-monitor::xprofiler',
  };

  config.httpTimeout = 15000;

  config.profilingTime = {
    start_cpu_profiling: 3 * 60 * 1000,
    start_heap_profiling: 3 * 60 * 1000,
    start_gc_profiling: 3 * 60 * 1000,
  };

  config.profilingTimeExtra = 60 * 1000;

  config.profilingTimeExpired = 300 * 1000;

  config.actionTime = {
    cpuprofile: {
      profilingTime: config.profilingTime.start_cpu_profiling + config.profilingTimeExtra,
      expired: config.profilingTime.start_cpu_profiling + config.profilingTimeExpired,
    },
    heapprofile: {
      profilingTime: config.profilingTime.start_heap_profiling + config.profilingTimeExtra,
      expired: config.profilingTime.start_heap_profiling + config.profilingTimeExpired,
    },
    gcprofile: {
      profilingTime: config.profilingTime.start_gc_profiling + config.profilingTimeExtra,
      expired: config.profilingTime.start_gc_profiling + config.profilingTimeExpired,
    },
    heapsnapshot: {
      profilingTime: config.profilingTimeExtra,
      expired: config.profilingTimeExpired,
    },
    diag: {
      profilingTime: config.profilingTimeExtra,
      expired: config.profilingTimeExpired,
    },
    core: {
      profilingTime: config.profilingTimeExtra,
      expired: config.profilingTimeExpired,
    },
  };

  config.uploadFileExpiredTime = 20 * 60 * 1000;

  config.auditExpiredTime = 15 * 1000;

  config.uploadNoncePrefix = 'XTRANSIT_UPLOAD_NONCE::';

  config.forceHttp = false;

  const userConfig = {};

  // async config
  userConfig.remoteConfig = {
    async handler(/* agent */) {
      // will override app.config
      return {
        // async config, eg:
        // mysql: { clients:{ xprofiler_console: { port: 3390 } } }
      };
    },
  };

  // mysql
  userConfig.mysql = {
    app: true,
    agent: false,
    clients: {
      xprofiler_console: {
        host: process.env['XPROFILER_CONSOLE_MYSQL_HOST'] || '',
        port: process.env['XPROFILER_CONSOLE_MYSQL_PORT'] || 3306,
        user: process.env['XPROFILER_CONSOLE_MYSQL_USER'] || '',
        password: process.env['XPROFILER_CONSOLE_MYSQL_PASSWORD'] || '',
        database: process.env['XPROFILER_CONSOLE_MYSQL_DATABASE'] || 'xprofiler_console',
      },
      xprofiler_logs: {
        host: process.env['XPROFILER_LOGS_MYSQL_HOST'] || '',
        port: process.env['XPROFILER_LOGS_MYSQL_PORT'] || 3306,
        user: process.env['XPROFILER_LOGS_MYSQL_USER'] || '',
        password: process.env['XPROFILER_LOGS_MYSQL_PASSWORD'] || '',
        database: process.env['XPROFILER_LOGS_MYSQL_DATABASE'] || 'xprofiler_logs',
      },
    },
  };

  // redis
  userConfig.redis = {
    client: {
      sentinels: process.env['REDIS_SENTINELS'] || null,
      port: process.env['REDIS_PORT'] || 6379,
      host: process.env['REDIS_HOST'] || '',
      password: process.env['REDIS_PASSWORD'] || '',
      db: process.env['REDIS_DB'] || 0,
    },
  };

  // xtransit upload file
  userConfig.xprofilerConsole = process.env['XPROFILER_CONSOLE_URL'] || 'http://127.0.0.1:8443';

  // xtransit manager
  userConfig.xtransitManager = process.env["XTRANSIT_MANAGER_URL"] || 'http://127.0.0.1:8543';


  console.log('--------config mysql--------', userConfig.mysql);

  console.log('--------config redis--------', userConfig.redis);

  console.log('--------config other--------', {
    ...config,
    ...userConfig
  });

  return {
    ...config,
    ...userConfig,
  };
};