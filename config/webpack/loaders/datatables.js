module.exports = {
    test: /datatables\.net.*/,
    loader: "imports-loader",
    options: {
        // Disables AMD plugin as DataTables.net
        // checks for AMD before CommonJS.
        additionalCode: "var define = false;",
    },
};