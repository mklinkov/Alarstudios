//
//  TestLoginUseCase.swift
//  AlarstudiosTests
//
//  Created by Maksim Linkov on 20.03.2022.
//

import XCTest
@testable import Alarstudios

final class TestLoginUseCase: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoinSuccess() {
        let expectation = expectation(description: "testLoinSuccess")
        let loginUseCase: LoginUseCase = LoginUseCase(loginRepository: LoginRepositoryUseCaseMockSuccess())
        var testResult: Result<LoginResponseModel, CustomError> = .failure(.unknownError)
        loginUseCase.invoke(ConstsForTests.mockLogin, ConstsForTests.mockPassword) { result in
            testResult = result
            expectation.fulfill()
        }
                
        wait(for: [expectation], timeout: 1.0)
            
        XCTAssertEqual(testResult, .success(LoginResponseModel(status: .ok, code: ConstsForTests.mockSessionKey)))
    }
    
    func testLoinFailure() {
        let expectation = expectation(description: "testLoinSuccess")

        let loginUseCase: LoginUseCase = LoginUseCase(loginRepository: LoginRepositoryUseCaseMockFailure())
        var testResult: Result<LoginResponseModel, CustomError> = .failure(.unknownError)
        loginUseCase.invoke(ConstsForTests.mockLogin, ConstsForTests.mockPassword) { result in
            testResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(testResult, .failure(.wrongLoginPassword))
        
    }
    
    func testLoinEmptyPassword() {
        let expectation = expectation(description: "testLoinSuccess")
        let loginUseCase: LoginUseCase = LoginUseCase(loginRepository: LoginRepositoryUseCaseMockSuccess())
        var testResult: Result<LoginResponseModel, CustomError> = .failure(.unknownError)
        loginUseCase.invoke(ConstsForTests.mockLogin, nil) { result in
            testResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(testResult, .failure(.validationPassworError))
    }
    
    func testLoinEmptyLogin() {
        let expectation = expectation(description: "testLoinSuccess")
        let loginUseCase: LoginUseCase = LoginUseCase(loginRepository: LoginRepositoryUseCaseMockSuccess())
        var testResult: Result<LoginResponseModel, CustomError> = .failure(.unknownError)
        loginUseCase.invoke(nil, ConstsForTests.mockPassword) { result in
            testResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(testResult, .failure(.validationLoginError))
    }
    
    func testLoinEmptyAll() {
        let expectation = expectation(description: "testLoinSuccess")
        let loginUseCase: LoginUseCase = LoginUseCase(loginRepository: LoginRepositoryUseCaseMockSuccess())
        var testResult: Result<LoginResponseModel, CustomError> = .failure(.unknownError)
        loginUseCase.invoke(nil, nil) { result in
            testResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(testResult, .failure(.validationLoginError))
    }
    
}
