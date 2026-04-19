module.exports = function(api) {
  const validEnv = ['development', 'test', 'production'];
  const currentEnv = api.env();

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      `Please specify a valid NODE_ENV or BABEL_ENV. Valid values are ${validEnv.join(', ')}. Received: ${currentEnv}`
    );
  }

  return {
    presets: [
      [
        '@babel/preset-env',
        {
          useBuiltIns: 'entry',
          corejs: '3.8',
          modules: 'auto',
          bugfixes: true,
          targets: currentEnv === 'test' ? { node: 'current' } : undefined,
        },
      ],
    ],
    plugins: [
      ['@babel/plugin-transform-runtime', { helpers: false }],
    ],
  };
};
