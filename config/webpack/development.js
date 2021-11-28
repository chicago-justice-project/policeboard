process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const custom = {
    optimization: {
        minimize: false
    }
};

module.exports = merger(environment.toWebpackConfig(),custom);
