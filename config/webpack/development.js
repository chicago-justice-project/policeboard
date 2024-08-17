const { merge } = require('webpack-merge');
process.env.NODE_ENV = process.env.NODE_ENV || 'development'


const environment = require('./environment')

const custom = {
    optimization: {
        minimize: false
    }
};

module.exports = merge(environment.toWebpackConfig(),custom);
