process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.config.merge({
    optimization: {
        minimize: false
    }
});

module.exports =environment.toWebpackConfig();
