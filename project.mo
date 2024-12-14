import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
import Option "mo:base/Option";
import List "mo:base/List";
import Text "mo:base/Text";
import Result "mo:base/Result";
import TrieMap "mo:base/TrieMap";

actor {
  public type product = {
    name: Text;
    quantity : Nat;
  };
  var inventory: TrieMap <Text, product> = TrieMap.Text<product>();

  public func addProduct(name: Text): async Text{
    if (inventory.containsKey(name)){
      return "bu ürün zaten var";
    } else {
      inventory.put(name, { name= name; quantity=0});
      return "ürün başariyla eklendi " #name;
      };
      
  };
  public func addStock(name : Text,amount : Nat): async Text{
    let product = inventory.get(name);
    let updatedProduct = { name = product.name ; quantity = product.quatity + amount};
    inventory.put(name,updatedProduct);
    return "stok arttirildi" #name # " , Yeni miktar: " # Nat.toText(updatedProduct.quantity)
  };

  public func removeStock(name:Text,amount:Nat): async Text {
    let Product =inventory.get(name);
    let updatedProduct = {name =product.name; quantity = product.quantity - amount};
    inventory.put(name,updatedProduct);
    return "Stok çikarildi: " #name# ", kalan miktar : " # Nat.toText(updatedProduct.quantity);

  };
  public query func getInventory(): async [(Text,Nat)]{
    return inventory.toArray().vals().map((product) > (product.name , product.quantity));
  };
};
