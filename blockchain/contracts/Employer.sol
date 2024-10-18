// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import "./JobSeeker.sol"; // Assuming JobSeeker contract is available

contract Employer {
    struct Vacancy {
        string title;
        uint salary;
        string position;
        string company;
        string description;
        string[] skills;
        string schedule;
        string workingHours;
        string location;
        SharedStructs.Contact[] contacts;
    }

    mapping(address => Vacancy[]) public vacancies;
    mapping(address => address[]) public jobSeekers; // Vacancy to JobSeeker mapping
    mapping(address => address) public selectedJobSeekers; // Accepted job seekers

    event VacancyCreated(address indexed employer, Vacancy vacancy);
    event VacancyUpdated(address indexed employer, Vacancy vacancy);
    event VacancyDeleted(address indexed employer, uint index);
    event JobSeekerListed(
        address indexed employer,
        address indexed jobSeeker,
        uint vacancyIndex
    );
    event JobSeekerAccepted(
        address indexed employer,
        address indexed jobSeeker
    );
    event JobSeekerDeclined(
        address indexed employer,
        address indexed jobSeeker
    );

    function createVacancy(Vacancy memory _vacancy) public {
        vacancies[msg.sender].push(_vacancy);
        emit VacancyCreated(msg.sender, _vacancy);
    }

    function readVacancy(uint _index) public view returns (Vacancy memory) {
        require(_index < vacancies[msg.sender].length, "Invalid vacancy index");
        return vacancies[msg.sender][_index];
    }

    function updateVacancy(uint _index, Vacancy memory _vacancy) public {
        require(_index < vacancies[msg.sender].length, "Invalid vacancy index");
        vacancies[msg.sender][_index] = _vacancy;
        emit VacancyUpdated(msg.sender, _vacancy);
    }

    function deleteVacancy(uint _index) public {
        require(_index < vacancies[msg.sender].length, "Invalid vacancy index");
        for (uint i = _index; i < vacancies[msg.sender].length - 1; i++) {
            vacancies[msg.sender][i] = vacancies[msg.sender][i + 1];
        }
        vacancies[msg.sender].pop();
        emit VacancyDeleted(msg.sender, _index);
    }

    function listCoverLetter(address _jobSeeker, uint _vacancyIndex) public {
        require(
            _vacancyIndex < vacancies[msg.sender].length,
            "Invalid vacancy index"
        );
        jobSeekers[msg.sender].push(_jobSeeker);
        emit JobSeekerListed(msg.sender, _jobSeeker, _vacancyIndex);
    }

    function getJobSeeker(
        uint _vacancyIndex
    ) public view returns (address[] memory) {
        require(
            _vacancyIndex < vacancies[msg.sender].length,
            "Invalid vacancy index"
        );
        return jobSeekers[msg.sender];
    }

    function acceptJobSeeker(address _jobSeeker) public {
        selectedJobSeekers[msg.sender] = _jobSeeker;
        emit JobSeekerAccepted(msg.sender, _jobSeeker);
    }

    function declineJobSeeker(address _jobSeeker) public {
        for (uint i = 0; i < jobSeekers[msg.sender].length; i++) {
            if (jobSeekers[msg.sender][i] == _jobSeeker) {
                for (uint j = i; j < jobSeekers[msg.sender].length - 1; j++) {
                    jobSeekers[msg.sender][j] = jobSeekers[msg.sender][j + 1];
                }
                jobSeekers[msg.sender].pop();
                break;
            }
        }
        emit JobSeekerDeclined(msg.sender, _jobSeeker);
    }
}
