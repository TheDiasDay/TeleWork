const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("EmployerModule", (m) => {
    const employer = m.contract("Employer");

    return { employer };
});
