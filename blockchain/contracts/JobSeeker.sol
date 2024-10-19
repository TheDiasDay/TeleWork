// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract JobSeeker {
    struct CoverLetter {
        address owner;
        string name;
        string surname;
        string middleName;
        string dateOfBirth;
        string education;
        string contacts;
        string skills;
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
        coverLetters[msg.sender] = _coverLetter;
        emit CoverLetterCreated(msg.sender, _coverLetter);
    }

    function updateCoverLetter(CoverLetter memory _updatedCoverLetter) public {
        require(
            coverLetters[msg.sender].owner != address(0),
            "Cover letter does not exist"
        );

        coverLetters[msg.sender] = _updatedCoverLetter;
        emit CoverLetterUpdated(msg.sender, _updatedCoverLetter);
    }

    function readCoverLetter() public view returns (CoverLetter memory) {
        return coverLetters[msg.sender];
    }

    function deleteCoverLetter() public {
        require(
            coverLetters[msg.sender].owner != address(0),
            "Cover letter does not exist"
        );
        delete coverLetters[msg.sender];
        emit CoverLetterDeleted(msg.sender);
    }
}
