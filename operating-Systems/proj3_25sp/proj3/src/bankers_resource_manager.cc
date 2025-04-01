
#include "../include/bankers_resource_manager.h"
#include "../../sync/include/thread_mutex.h" // change this to be correct!!!
#include <cstddef>
#include <vector>
#include <iostream>


using namespace std;

BankersResourceManager::BankersResourceManager(const vector<size_t>& available)
    : available(available) {}


    void BankersResourceManager::AddMax(const vector<size_t>& max) {
        ::ThreadMutexGuard varname(mutex);
        this->max.push_back(max);
        allocated.push_back(vector<size_t>(available.size(),0));
        need.push_back(max);

    }

    bool BankersResourceManager::Request(size_t id, const vector<size_t>& request) {
        ::ThreadMutexGuard varname(mutex);
        cout << " Thread " << id << " has requested: { ";
        for(size_t i = 0; i < request.size(); i++) {
            cout << request[i] << " ";
        }
        cout << "}" << endl;

        cout << " Need { ";
        for(size_t i = 0; i < request.size(); i++) {
            cout << need[id][i] << " ";
        }
        cout << "}" << endl;

        cout << " available { ";
        for(size_t i = 0; i < request.size(); i++) {
            cout << available[i] << " ";
        }
        cout << "}" << endl;

        //  check if request is more that needed
        for(size_t i = 0; i < request.size(); i++) {

            if(request[i] + allocated[id][i] > max[id][i]) {
                // print denied, request too much resources

                cout << "request denied, requested more resources than needed" << endl;

                return false;
            }
            if(request[i] > available[i]) {
                // print denied, request cant be honored due to lack of resourses
                cout << "request denied, not enough resources for request" << endl;
                return false;
            }
        }


        vector<size_t> temp_available = available;
        vector<vector<size_t>> temp_allocated = allocated;
        vector<vector<size_t>> temp_need = need;
        if(IsSafe(id, request, temp_available, temp_allocated, temp_need )) {
            for(size_t i = 0; i < available.size();i++) {
                allocated[id][i] += request[i];
                need[id][i] -= request[i];
                available[i] -= request[i];
            }
            cout << "request accepted" << endl;  // add more context later
            return true;
        }
        else {
            return false;
        }
    }

    void BankersResourceManager::Release(size_t id) {
        ::ThreadMutexGuard varname(mutex);
        vector<size_t> released = allocated[id];
        for(size_t i = 0; i < available.size(); i++) {
           // cout << "________________________________________________________" << endl;
            available[i] += allocated[id][i];
            allocated[id][i] = 0;
            need[id][i] = 0;
        }
        // print statement

    }

    bool BankersResourceManager::IsSafe(size_t id,const vector<size_t>& request, vector<size_t>& temp_available,
        vector<vector<size_t>>& temp_allocated,
        vector<vector<size_t>>& temp_need ) {  // returns if there is a safe order of execution
        size_t n = max.size();
        vector<bool> finish(n, false);
        vector<size_t> safeOrder;
        for(size_t i = 0; i < temp_available.size();i++) { 
            temp_allocated[id][i] += request[i];
            temp_need[id][i] -= request[i];
            temp_available[i] -= request[i]; 
        }
        for(size_t i = 0; i < n; i++) {
            for(size_t j = 0; j < n; j++) {
                if(!finish[j]) {
                    bool possible = true;
                    
                    for(size_t k = 0;k < temp_available.size();k++) { 
                        if(temp_need[j][k] > temp_available[k]) {
                            possible = false;  //  cant meet needs, move on.
                            break;
                            }
                        }
                    if(possible) {        
                    for(size_t k = 0; k < available.size();k++) {
                        temp_available[k] += temp_allocated[j][k];  // letting go of resourse
                    }
                    safeOrder.push_back(j);  // adding process to the order
                    finish[j] = true;
                    }
                }
            }
        }
        

        for(size_t i = 0; i < finish.size(); i++) {
            if(!finish[i]){
                cout << "request denied, no safe sequence" << endl;
                return false;
            }
        }
        cout << " safe order { ";
        for(size_t i = 0; i < safeOrder.size(); i++) {
            cout << "p" << safeOrder[i] << " ";
        }
        cout << "}" << endl;

        return true; 
        

    }

    
    