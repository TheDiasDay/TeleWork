const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("JobSeekerModule", (m) => {
    const jobSeeker = m.contract("JobSeeker");

    const testAddr = "0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199";

    const coverLetter = {
        owner: testAddr,
        name: "John",
        surname: "Doe",
        middleName: "Middle",
        dateOfBirth: "1990-01-01",
        education: "Nazarbayev University",
        contacts: "john.doe@example.com",
        skills: "Solidity, git, Redis, gRPC"
    };

    m.call(jobSeeker, "createCoverLetter", [coverLetter], { from: testAddr });

    return { jobSeeker };
});
