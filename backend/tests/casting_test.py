from fastapi.testclient import TestClient

from routes.casting import casting, get_castings

client = TestClient(casting)

def get_all_castings_test():
    response = client.get("/castings")
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("GET ALL CASTINGS TEST PASSED")

    if (response.status_code != 200):
        print ("GET ALL CASTINGS TEST NOT PASSED")
        print (response.status_code)  

def create_casting_test():
    response = client.post(
        "/castings",
        headers = {"Content-Type": "application/json"},
        json = 
        {
        "id": 99,
        "name": "Test",
        },
    )
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("CREATE CASTING TEST PASSED")

    if (response.status_code != 200):
        print ("CREATE CASTING TEST NOT PASSED")
        print (response.status_code)  


def get_one_casting_test():
    response = client.get("/castings/99")
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("GET ONE CASTING TEST PASSED")

    if (response.status_code != 200):
        print ("GET ONE CASTING TEST NOT PASSED")
        print (response.status_code)  

def update_casting_test():
    response = client.put("/castings/update/99",
    headers = {"Content-Type": "application/json"},
        json = 
        {
        "id": 99,
        "name": "TestUpdate",
        },
    )
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("UPDATE CASTING TEST PASSED")

    if (response.status_code != 200):
        print ("UPDATE CASTING TEST NOT PASSED") 
        print (response.status_code)

def delete_casting_test():
    response = client.get("/castings/delete/99")  
    if (response.status_code == 200):
        assert response.status_code == 200
        print ("DELETE CASTING TEST PASSED")

    if (response.status_code != 200):
        print ("DELETE CASTING TEST NOT PASSED") 
        print (response.status_code)