// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract Employer {
    struct Vacancy {
        address owner;
        uint256 id;
        string title;
        uint salary;
        string position;
        string company;
        string description;
        string skills;
        string schedule;
        string workingHours;
        string location;
        string contacts;
    }

    // Mapping from employer address to their list of vacancies
    mapping(address => Vacancy[]) public vacancies;

    // Global counter to track vacancy IDs
    uint256 public nextVacancyId = 1;

    event VacancyCreated(address indexed employer, Vacancy vacancy);
    event VacancyUpdated(address indexed employer, Vacancy vacancy);
    event VacancyDeleted(address indexed employer, uint index);

    function createVacancy(Vacancy memory _vacancy) public {
        _vacancy.id = nextVacancyId;
        _vacancy.owner = msg.sender;

        nextVacancyId++;

        vacancies[msg.sender].push(_vacancy);

        emit VacancyCreated(msg.sender, _vacancy);
    }

    function readVacancy(uint _index) public view returns (Vacancy memory) {
        require(_index < vacancies[msg.sender].length, "Invalid vacancy index");
        return vacancies[msg.sender][_index];
    }

    function updateVacancy(uint _index, Vacancy memory _vacancy) public {
        require(_index < vacancies[msg.sender].length, "Invalid vacancy index");
        _vacancy.id = vacancies[msg.sender][_index].id;
        _vacancy.owner = vacancies[msg.sender][_index].owner;
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
}
