// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

library SharedStructs {
    struct Contact {
        string name;
        string value;
    }
}

contract JobSeeker {
    struct CoverLetter {
        address id;
        string name;
        string surname;
        string middleName;
        string dateOfBirth;
        Education[] education;
        SharedStructs.Contact[] contacts;
        string[] skills;
    }

    struct Education {
        string name;
        string period;
        string level;
        string GPA;
    }

    mapping(address => CoverLetter) public coverLetters;

    event CoverLetterCreated(
        address indexed jobSeeker,
        CoverLetter coverLetter
    );
    event CoverLetterUpdated(
        address indexed jobSeeker,
        CoverLetter coverLetter
    );
    event CoverLetterDeleted(address indexed jobSeeker);

    function createCoverLetter(CoverLetter memory _coverLetter) public {
        CoverLetter storage cl = coverLetters[msg.sender];

        cl.id = _coverLetter.id;
        cl.name = _coverLetter.name;
        cl.surname = _coverLetter.surname;
        cl.middleName = _coverLetter.middleName;
        cl.dateOfBirth = _coverLetter.dateOfBirth;

        // Copying the education array manually
        delete cl.education; // Ensure it's cleared before copying
        for (uint i = 0; i < _coverLetter.education.length; i++) {
            cl.education.push(_coverLetter.education[i]);
        }

        // Copying the contacts array manually
        delete cl.contacts; // Ensure it's cleared before copying
        for (uint i = 0; i < _coverLetter.contacts.length; i++) {
            cl.contacts.push(_coverLetter.contacts[i]);
        }

        cl.skills = _coverLetter.skills;

        emit CoverLetterCreated(msg.sender, _coverLetter);
    }

    function updateCoverLetter(CoverLetter memory _updatedCoverLetter) public {
        require(
            coverLetters[msg.sender].id != address(0),
            "Cover letter does not exist"
        );

        CoverLetter storage cl = coverLetters[msg.sender];

        cl.id = _updatedCoverLetter.id;
        cl.name = _updatedCoverLetter.name;
        cl.surname = _updatedCoverLetter.surname;
        cl.middleName = _updatedCoverLetter.middleName;
        cl.dateOfBirth = _updatedCoverLetter.dateOfBirth;

        // Copying the education array manually
        delete cl.education; // Ensure it's cleared before copying
        for (uint i = 0; i < _updatedCoverLetter.education.length; i++) {
            cl.education.push(_updatedCoverLetter.education[i]);
        }

        // Copying the contacts array manually
        delete cl.contacts; // Ensure it's cleared before copying
        for (uint i = 0; i < _updatedCoverLetter.contacts.length; i++) {
            cl.contacts.push(_updatedCoverLetter.contacts[i]);
        }

        cl.skills = _updatedCoverLetter.skills;

        emit CoverLetterUpdated(msg.sender, _updatedCoverLetter);
    }

    function readCoverLetter() public view returns (CoverLetter memory) {
        return coverLetters[msg.sender];
    }

    function deleteCoverLetter() public {
        require(
            coverLetters[msg.sender].id != address(0),
            "Cover letter does not exist"
        );
        delete coverLetters[msg.sender];
        emit CoverLetterDeleted(msg.sender);
    }
}
