    


/*struct Dog {
    name: String,
    breed: String,
}
trait walkable { 
    fn walk(&self);
}
impl walkable for Dog {
    // Define a method for walking the dog
    fn walk(&self) {
        println!("{} the {} is going for a walk!", self.name, self.breed);
    }
}
fn dog_walker(dog: Dog) {
    println!("Sent {} the {} to the dog walker", dog.name, dog.breed);
    dog.walk(); // Borrowed dog can still be used as long as we do not modify or move it
}
/* 
fn main(){
    let myDog = Dog {
        name: String::from("Buddy"),
        breed: String::from("Golden Retriever"),
    };         
    myDog.walk();// prints : "Buddy the Golden Retriever is going for a walk!" i successfuly walked my dog
    let friend = myDog; // my friend is now assigned my dog. rust will move ownership to my friend.

    friend.walk();
    myDog.walk();               //logically i cant walk a dog that im not in possession in so this line will 
                                //cause an error
    
   

}
*/

/*fn main(){
    let myDog = Dog {
        name: String::from("Buddy"),
        breed: String::from("Golden Retriever"),
    };
    myDog.walk(); // prints : "Buddy the Golden Retriever is going for a walk!" succeeds
    dog_walker(myDog); // ownership can be passed to a function. prints "Sent Buddy the Golden Retriever to the dog walker"
    myDog.walk();          // this wont work because once the dog went out of scope its value was dropped from the heap

}
*/

trait Fly {
    fn fly(&self) {
        println!("Flying"); // default case
    }
}

trait Swim {
    fn swim(&self) {
        println!("Swimming"); // default case
    }
}

trait FlyAndSwim: Fly + Swim {} // trait that requires both Fly and Swim

struct Duck;

impl Fly for Duck {} // duck uses the default implementation
impl Swim for Duck {} 
impl FlyAndSwim for Duck {} // duck had both fly and swim so it can implement FlyandSwim
struct Penguin;

impl Fly for Penguin {
    fn fly(&self) {
        println!("pretends to fly"); //overwrites default
    }
}
*/
fn main() {
    let mut arr = vec![64, 34, 25, 8, 22, 11, 9];
    let sorted_arr = merge_sort(&mut arr);
    println!("{:?}", sorted_arr); // [8, 9, 11, 22, 25, 34, 64]
}
fn merge_sort<T: Ord + Clone>(arr: &mut [T]) -> Vec<T>
{
    if arr.len() <= 1 {
        arr.to_vec()
    } else {
        let mid = arr.len() / 2;
        let left = merge_sort(&mut arr[..mid]).clone();
        let right = merge_sort(&mut arr[mid..]).clone();
        merge(left, right)
    }
}
fn merge<T: Ord + Clone>(left: Vec<T>, right: Vec<T>) -> Vec<T>
{
    let mut result = Vec::new();
    let mut i = 0;
    let mut j = 0;
    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            result.push(left[i].clone());
            i += 1;
        } else {
            result.push(right[j].clone());
            j += 1;
        }
    }
    result.extend_from_slice(&left[i..]); 
    result.extend_from_slice(&right[j..]);
    result
}






    


