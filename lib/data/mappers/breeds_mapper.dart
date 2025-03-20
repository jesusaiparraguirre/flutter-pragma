import 'package:pragma_test/models/entities/breed_entity.dart';
import 'package:pragma_test/models/responses/breed_response.dart';

class BreedsMapper {
  static Breed breedToEntity(BreedResponse breed) =>  Breed(
    weight: breed.weight,
    id: breed.id, 
    name: breed.name, 
    cfaUrl: breed.cfaUrl, 
    vetstreetUrl: breed.vetstreetUrl, 
    vcahospitalsUrl: breed.vcahospitalsUrl, 
    temperament: breed.temperament, 
    origin: breed.origin, 
    countryCodes: breed.countryCodes, 
    countryCode: breed.countryCode, 
    description: breed.description, 
    lifeSpan: breed.lifeSpan, 
    indoor: breed.indoor, 
    lap: breed.lap, 
    altNames: breed.altNames, 
    adaptability: breed.adaptability, 
    affectionLevel: breed.affectionLevel, 
    childFriendly: breed.childFriendly, 
    dogFriendly: breed.dogFriendly, 
    energyLevel: breed.energyLevel, 
    grooming: breed.grooming, 
    healthIssues: breed.healthIssues, 
    intelligence: breed.intelligence, 
    sheddingLevel: breed.sheddingLevel, 
    socialNeeds: breed.socialNeeds, 
    strangerFriendly: breed.strangerFriendly, 
    vocalisation: breed.vocalisation, 
    experimental: breed.experimental, 
    hairless: breed.hairless, 
    natural: breed.natural, 
    rare: breed.rare, 
    rex: breed.rex, 
    suppressedTail: breed.suppressedTail, 
    shortLegs: breed.shortLegs, 
    wikipediaUrl: breed.wikipediaUrl, 
    hypoallergenic: breed.hypoallergenic, 
    referenceImageId: breed.referenceImageId
  );
}