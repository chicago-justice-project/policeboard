const { generateWebpackConfig, merge } = require('shakapacker');
const webpack = require('webpack');

const baseConfig = generateWebpackConfig();

const custom = {
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      fa: 'font-awesome',
    }),
  ],
  module: {
    rules: [
      {
        test: require.resolve('jquery'),
        loader: 'expose-loader',
        options: { exposes: [{ globalName: '$', override: true }, 'jQuery'] },
      },
      {
        test: /datatables\.net.*/,
        loader: 'imports-loader',
        options: { additionalCode: 'var define = false;' },
      },
      {
        test: require.resolve('jquery-sparkline'),
        loader: 'imports-loader',
        options: { additionalCode: 'var define = false;' },
      },
    ],
  },
};

if (process.env.NODE_ENV === 'development') {
  custom.optimization = { minimize: false };
}

module.exports = merge(baseConfig, custom);
