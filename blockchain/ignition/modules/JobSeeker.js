const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("JobSeekerModule", (m) => {
    // Deploy the JobSeeker contract
    const jobSeeker = m.contract("JobSeeker");

    // You can also configure specific default actions or initial setup
    // For example, if you want to call `createCoverLetter` after deployment, you could define the CoverLetter

    // Sample cover letter data for initial setup (optional)
    const coverLetter = {
        id: "0x0000000000000000000000000000000000000000",  // Replace with a valid address
        name: "John",
        surname: "Doe",
        middleName: "Middle",
        dateOfBirth: "1990-01-01",
        education: [
            {
                name: "Sample University",
                period: "2010-2014",
                level: "Bachelor",
                GPA: "3.5"
            }
        ],
        contacts: [
            {
                name: "email",
                value: "john.doe@example.com"
            }
        ],
        skills: ["Solidity", "Blockchain", "Hardhat"]
    };

    // Call createCoverLetter as part of the deployment (optional)
    m.call(jobSeeker, "createCoverLetter", [coverLetter], { from: "0xYourDeployerAddress" });

    return { jobSeeker };
});
