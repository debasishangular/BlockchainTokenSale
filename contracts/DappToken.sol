pragma solidity >=0.4.21 <0.6.0;

contract DappToken {

    string  public name = "DebToken";
    string  public symbol = "DET";
    string  public standard = "Deb Token v1.0";
    uint256 public totalSupply;

   // transfer event
   event Transfer (address indexed _from , 
                   address indexed _to ,
                   uint256 _value);

    // approve event
    event Approval (address indexed _owner ,
                   address indexed _spender ,
                   uint256 _value);

    mapping(address => uint256) public balanceOf;//amount present at particular address
    mapping(address =>mapping(address=>uint256)) public allowance;

    // constructor
    constructor(uint256 _initialSupply) public {
        // allocate the initial supply to particluar address
        balanceOf[msg.sender]= _initialSupply;
        totalSupply = _initialSupply; // This is the storage variable
    }

    // Transfer Function
    function transfer(address _to,uint256 _value) public  returns(bool){
    // Exception if account does not have enough balance
    require(balanceOf[msg.sender] >= _value);
    // Transfer the balance
    balanceOf[msg.sender]-= _value;
    balanceOf[_to]+= _value;
    // Trigger a transfer Event
    emit Transfer(msg.sender,_to,_value);
    // Return boolean value
    return true;
    }

    // approve
    function approve(address _spender,uint256 _value)public returns (bool){
        // allowance
        allowance[msg.sender][_spender]=_value;
        // approval event
        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    // transferFrom
   function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){

       //1. Require _from has enough tokens greater then value
       //2. Require allowance is greater then _value
       //3. Transfer event
       //4. change the balance
       //5. update the allowance
       //6. return a boolean

        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        emit Transfer(_from,_to,_value);
        balanceOf[_from]-=_value;
        balanceOf[_to]+=_value;
        allowance[_from][msg.sender]-=_value;
        return true;
   } 
   
    

}

/*
Steps :
    1. set the initial number of tokens inside constructor(initially hard coded)
    2. assign the initial amount to proper address
    3. initialize the contract with correct Values
    4. Add a transfer function
    5. Approve Function - approves that 'B' can transfer 'C' token from 
       'A'account on behalf of A,i.e we are approving exchange to sell 'C' amount of coins on our(A) behalf
       and after approval transferFrom  function takes care of transferring the amount.
       approve and transferFrom are delegated transfer functions
    6. allowance - mapping that holds the details of approval that owner has given to spender.
    ex:    owner     ->    spender      -> amount 
         A(0xA000)   ->  B(0xAAB000)   -> 30
         A(0xA000)   ->  C(0xxAD000)   -> 50
    7. approval event - whenever we call approve function and it is successful this event 
       is getting triggered
    8. TransferFrom function - behaves like transfer but on behalf of some third party.On 
       successfull transfer must fire the transfer event.
       There are 3 accounts basically involved in this function 
       1. the account transferring the amount (acc B)
       2. the account from which amount is being transferred(_from)
       3. the account to which amount is being transferred to.
*/