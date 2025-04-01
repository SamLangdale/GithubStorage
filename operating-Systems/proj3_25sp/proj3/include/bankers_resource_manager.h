#ifndef THREADMANAGER_H
#define THREADMANAGER_H


#include <cstddef>
#include <vector>
#include "../../sync/include/thread_mutex.h"

using namespace std;



class BankersResourceManager {
    public:

    BankersResourceManager(const vector<size_t>& available);

    void AddMax(const vector<size_t>& Max);

    bool Request(size_t index,const vector<std::size_t>& request);

    void Release(size_t id);

    private:

    vector<size_t> available;
    vector<vector<std::size_t>> max;
    vector<vector<size_t>> allocated;
    vector<vector<size_t>> need;
    ::ThreadMutex mutex;


    private: 

        bool IsSafe(size_t id, const vector<size_t>& request,
            vector<size_t>& temp_available,
            vector<vector<size_t>>& temp_allocated,
            vector<vector<size_t>>& temp_need );
};










#endif //   THREAD