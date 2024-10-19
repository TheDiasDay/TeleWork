const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("JobSeekerModule", (m) => {
    const jobSeeker = m.contract("JobSeeker");

    const coverLetter = {
        id: "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955",
        name: "John",
        surname: "Doe",
        middleName: "Middle",
        dateOfBirth: "1990-01-01",
        education: "Nazarbayev University",
        contacts: "john.doe@example.com",
        skills: "Solidity, git, Redis, gRPC"
    };

    m.call(jobSeeker, "createCoverLetter", [coverLetter], { from: "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955" });

    return { jobSeeker };
});
