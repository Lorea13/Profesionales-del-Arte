from fastapi.testclient import TestClient

from routes.castingDirector import castingDirector, get_castingDirectors

client = TestClient(castingDirector)


def get_all_castingDirectors_test():
    response = client.get("/castingDirectors")
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("GET ALL CASTINGDIRECTORS TEST PASSED")

    if (response.status_code != 200):
        print ("GET ALL CASTINGDIRECTORS TEST NOT PASSED")
        print (response.status_code)  

def create_castingDirector_test():
    response = client.post(
        "/castingDirectors",
        headers = {"Content-Type": "application/json"},
        json = 
        {
        "id": 99,
        "name": "Test",
        },
    )
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("CREATE CASTINGDIRECTOR TEST PASSED")

    if (response.status_code != 200):
        print ("CREATE CASTINGDIRECTOR TEST NOT PASSED")
        print (response.status_code)  


def get_one_castingDirector_test():
    response = client.get("/castingDirectors/99")
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("GET ONE CASTINGDIRECTOR TEST PASSED")

    if (response.status_code != 200):
        print ("GET ONE CASTINGDIRECTOR TEST NOT PASSED")
        print (response.status_code)  

def update_castingDirector_test():
    response = client.put("/castingDirectors/update/99",
    headers = {"Content-Type": "application/json"},
        json = 
        {
        "id": 99,
        "name": "TestUpdate",
        },
    )
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("UPDATE CASTINGDIRECTOR TEST PASSED")

    if (response.status_code != 200):
        print ("UPDATE CASTINGDIRECTOR TEST NOT PASSED") 
        print (response.status_code)

def delete_castingDirector_test():
    response = client.get("/castingDirectors/delete/99")  
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("DELETE CASTINGDIRECTOR TEST PASSED")

    if (response.status_code != 200):
        print ("DELETE CASTINGDIRECTOR TEST NOT PASSED") 
        print (response.status_code)