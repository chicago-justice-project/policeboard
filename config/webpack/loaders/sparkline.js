module.exports = {
    test:  require.resolve("jquery-sparkline"),
    loader: "imports-loader",
    options: {
        // Disables AMD plugin as DataTables.net
        // checks for AMD before CommonJS.
        additionalCode: "var define = false;",
    },
};