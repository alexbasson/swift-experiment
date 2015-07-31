import Quick
import Nimble
import SwiftExperiment

class PostersSpec: QuickSpec {
    override func spec() {

      let thumbnailURL = NSURL(string: "thumbnailURL")!
      let profileURL = NSURL(string: "profileURL")!
      let detailedURL = NSURL(string: "detailedURL")!
      let originalURL = NSURL(string: "originalURL")!
      let unequalURL = NSURL(string: "unequalURL")!

      describe("==") {
        var subject: Posters!
        var equalToSubject: Posters!
        var unequalToSubject: Posters!

        beforeEach {
          subject = Posters(thumbnailURL: thumbnailURL, profileURL: profileURL, detailedURL: detailedURL, originalURL: originalURL)
        }

        it("equates posters with the same urls") {
          equalToSubject = Posters(thumbnailURL: thumbnailURL, profileURL: profileURL, detailedURL: detailedURL, originalURL: originalURL);
          expect(subject).to(equal(equalToSubject))
        }

        it("unequates posters with different thumbnail urls") {
          unequalToSubject = Posters(thumbnailURL: unequalURL, profileURL: profileURL, detailedURL: detailedURL, originalURL: originalURL)
          expect(subject).notTo(equal(unequalToSubject))
        }

        it("unequates posters with different profile urls") {
          unequalToSubject = Posters(thumbnailURL: thumbnailURL, profileURL: unequalURL, detailedURL: detailedURL, originalURL: originalURL)
          expect(subject).notTo(equal(unequalToSubject))
        }

        it("unequates posters with different detailed urls") {
          unequalToSubject = Posters(thumbnailURL: thumbnailURL, profileURL: profileURL, detailedURL: unequalURL, originalURL: originalURL)
          expect(subject).notTo(equal(unequalToSubject))
        }

        it("unequates posters with different original urls") {
          unequalToSubject = Posters(thumbnailURL: thumbnailURL, profileURL: profileURL, detailedURL: detailedURL, originalURL: unequalURL)
          expect(subject).notTo(equal(unequalToSubject))
        }
      }

      describe("serializable") {
        var subject: Posters!
        var dictionary: Dictionary<String, AnyObject>!

        describe("serialize") {
          beforeEach {
            subject = Posters()
          }

          it("serializes the posters") {
            let dict = subject.serialize()
            expect(dict["thumbnail"] as? String).to(equal("example.com/posters/thumbnail"))
            expect(dict["profile"] as? String).to(equal("example.com/posters/profile"))
            expect(dict["detailed"] as? String).to(equal("example.com/posters/detailed"))
            expect(dict["original"] as? String).to(equal("example.com/posters/original"))
          }
        }

        describe("init(dict:))") {
          beforeEach {
            subject = Posters()
            dictionary = [
              "thumbnail": "example.com/posters/thumbnail",
              "profile": "example.com/posters/profile",
              "detailed": "example.com/posters/detailed",
              "original": "example.com/posters/original"
            ]
          }

          it("deserialized the dictionary into Posters") {
            expect(Posters(dict: dictionary)).to(equal(subject))
          }
        }
      }
    }
}
